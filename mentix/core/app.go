/**************************************************************************************************
 * File:   app.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package core

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"time"

	"github.com/sciencemesh/mentix/core/logging"
)

type mentixApp struct {
	appDir string

	config *mentixConfig
	logger *logging.TextLogger
}

var (
	appInstance *mentixApp
)

func (app *mentixApp) initialize() error {
	// Parse any provided commandline flags
	flag.Parse()

	// Get the directory of Mentix
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		return fmt.Errorf("could not retrieve app directory: %v", err)
	}
	app.appDir = dir

	// Prepare the configuration
	app.config = newMentixConfig(app)
	if err := app.config.Load(app.getConfigFilename()); err != nil {
		return fmt.Errorf("unable to load the Mentix configuration: %v", err)
	}

	// Initialize logging; this has to be done after loading the configuration, as the log directory is needed for this
	logger, err := logging.NewTextLogger(app.getLogFilename(), app.config.Core.Logging.Enabled, app.config.Core.Logging.Level)
	if err != nil {
		return fmt.Errorf("unable to initialize logging: %v", err)
	}
	app.logger = logger

	app.logSessionStart()
	return nil
}

func (app *mentixApp) shutdown() {
	app.logger.Close()

	app.logSessionEnd()
}

func (app *mentixApp) getConfigFilename() string {
	// If a configuration file was specified via commandline, use that one; otherwise, use the default one
	configFile := *flag_configFile
	if len(configFile) == 0 {
		configFile = fn_configFile
	}

	// Relative filenames are treated to be relative to the Mentix app dir
	if !filepath.IsAbs(configFile) {
		configFile = app.SafeResolveFilename(configFile)
	}

	return configFile
}

func (app *mentixApp) getLogFilename() string {
	timestamp := time.Now()
	filename := fmt.Sprintf("mentix-%d-%02d-%02d.log", timestamp.Year(), timestamp.Month(), timestamp.Day())
	return app.SafeResolvePath(app.config.Core.Logging.Directory, filename)
}

func (app *mentixApp) Run() error {
	// Shut down the app automatically after Run() has finished
	defer app.shutdown()

	// TODO: Do sumthin'
	return nil
}

func (app *mentixApp) ResolveFilename(filename string) string {
	dir, file := filepath.Split(filename)
	return app.ResolvePath(dir, file)
}

func (app *mentixApp) SafeResolveFilename(filename string) string {
	dir, file := filepath.Split(filename)
	return app.SafeResolvePath(dir, file)
}

func (app *mentixApp) ResolvePath(dir string, filename string) string {
	filename = filepath.Join(dir, filename)
	if filepath.IsAbs(filename) {
		return filename
	} else {
		return filepath.Join(app.appDir, filename)
	}
}

func (app *mentixApp) SafeResolvePath(dir string, filename string) string {
	resolvedFilename := app.ResolvePath(dir, filename)

	// Create directory tree
	if len(filename) == 0 { // No filename provided
		os.MkdirAll(resolvedFilename, os.ModePerm)
	} else {
		os.MkdirAll(filepath.Dir(resolvedFilename), os.ModePerm)
	}

	return resolvedFilename
}

func (app *mentixApp) logSessionStart() {
	app.logger.Info("<b>Mentix session started:")
	app.logger.Infof("\t<b>Version:</> %v", GetVersionStringWithBuild())
	app.logger.Infof("\t<b>Configuration:</> %v", app.getConfigFilename())

	if app.config.Core.Logging.Enabled {
		app.logger.Infof("\t<b>Log file:</> %v", app.getLogFilename())
	}
}

func (app *mentixApp) logSessionEnd() {
	app.logger.Info("<b>Mentix session ended")
}

func (app *mentixApp) Config() *mentixConfig {
	return app.config
}

func (app *mentixApp) Log() *logging.TextLogger {
	return app.logger
}

func NewMentixApp() (*mentixApp, error) {
	// Ensure that only one Mentix app exists
	if appInstance != nil {
		return appInstance, nil
	} else {
		appInstance = new(mentixApp)
		if err := appInstance.initialize(); err != nil {
			return nil, fmt.Errorf("unable to initialize the Mentix app: %v", err)
		}
		return appInstance, nil
	}
}

func Mentix() *mentixApp {
	if appInstance == nil {
		// This should never happen
		log.Fatal("Accessed uninitialized Mentix app")
	}

	return appInstance
}
