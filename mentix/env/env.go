/**************************************************************************************************
 * File:   env.go
 * Date:   2020-05-08
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package env

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"time"

	"github.com/sciencemesh/mentix/core/logging"
	"github.com/sciencemesh/mentix/env/config"
)

type Environment struct {
	appDir string

	config *config.Config
	logger *logging.Logger
}

func (env *Environment) initialize() error {
	// Parse any provided commandline flags
	flag.Parse()

	// Get the main application directory
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		return fmt.Errorf("could not retrieve app directory: %v", err)
	}
	env.appDir = dir

	// Initialize the app configuration
	if err := env.initConfiguration(); err != nil {
		return fmt.Errorf("unable to initialize configuration: %v", err)
	}

	// Initialize logging; this has to be done after loading the configuration, as the log directory is needed for this
	if err := env.initLogging(); err != nil {
		return fmt.Errorf("unable to initialize logging: %v", err)
	}

	return nil
}

func (env *Environment) Close() {
	env.logger.Close()
}

func (env *Environment) initConfiguration() error {
	// Create the configuration and apply various default settings
	cfg, err := config.NewConfig(func(cfg *config.Config) error {
		cfg.Core.Logging.Enabled = true
		cfg.Core.Logging.Directory = env.ResolvePath(config.FN_LogsDir, "")
		cfg.Core.Logging.Level = logging.LevelInfo

		cfg.Engine.Connector = config.ConnectorID_GOCDB
		cfg.Engine.Exporters = []string{config.ExporterID_PrometheusFileSD}
		cfg.Engine.UpdateInterval = "1h"

		return nil
	})
	if err != nil {
		return fmt.Errorf("unable to create configuration: %v", err)
	}
	env.config = cfg

	// Load any existing configuration file
	if err := env.config.Load(env.GetConfigFilename()); err != nil {
		return fmt.Errorf("unable to load the Mentix configuration: %v", err)
	}

	return nil
}

func (env *Environment) initLogging() error {
	logger, err := logging.NewLogger(env.GetLogFilename(), env.config.Core.Logging.Enabled, env.config.Core.Logging.Level)
	if err != nil {
		return fmt.Errorf("unable to create a text logger: %v", err)
	}
	env.logger = logger

	return nil
}

func (env *Environment) GetConfigFilename() string {
	// If a configuration file was specified via commandline, use that one; otherwise, use the default one
	configFile := *CLI_ConfigFile
	if len(configFile) == 0 {
		configFile = config.FN_ConfigFile
	}

	// Relative filenames are treated to be relative to the Mentix app dir
	if !filepath.IsAbs(configFile) {
		configFile = env.SafeResolveFilename(configFile)
	}

	return configFile
}

func (env *Environment) GetLogFilename() string {
	timestamp := time.Now()
	filename := fmt.Sprintf("mentix-%d-%02d-%02d.log", timestamp.Year(), timestamp.Month(), timestamp.Day())
	return env.SafeResolvePath(env.config.Core.Logging.Directory, filename)
}

func (env *Environment) ResolveFilename(filename string) string {
	dir, file := filepath.Split(filename)
	return env.ResolvePath(dir, file)
}

func (env *Environment) SafeResolveFilename(filename string) string {
	dir, file := filepath.Split(filename)
	return env.SafeResolvePath(dir, file)
}

func (env *Environment) ResolvePath(dir string, filename string) string {
	filename = filepath.Join(dir, filename)
	if filepath.IsAbs(filename) {
		return filename
	} else {
		return filepath.Join(env.appDir, filename)
	}
}

func (env *Environment) SafeResolvePath(dir string, filename string) string {
	resolvedFilename := env.ResolvePath(dir, filename)

	// Create directory tree
	if len(filename) == 0 { // No filename provided
		os.MkdirAll(resolvedFilename, os.ModePerm)
	} else {
		os.MkdirAll(filepath.Dir(resolvedFilename), os.ModePerm)
	}

	return resolvedFilename
}

func (env *Environment) AppDir() string {
	return env.appDir
}

func (env *Environment) Config() *config.Config {
	return env.config
}

func (env *Environment) Log() *logging.Logger {
	return env.logger
}

func NewEnvironment() (*Environment, error) {
	env := new(Environment)
	if err := env.initialize(); err != nil {
		return nil, fmt.Errorf("unable to initialize environment: %v", err)
	}
	return env, nil
}
