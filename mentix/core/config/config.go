/**************************************************************************************************
 * File:   config.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package config

import (
	"fmt"
	"os"
	"path/filepath"

	"gopkg.in/yaml.v2"

	"github.com/sciencemesh/mentix/core/logging"
)

type mentixSettings struct {
	Core struct {
		Logging struct {
			Enabled   bool   `yaml:"enabled"`
			Directory string `yaml:"directory"`
			Level     int    `yaml:"level"`
		} `yaml:"logging"`
	} `yaml:"general"`

	Engine struct {
		Connector string `yaml:"connector"`
	} `yaml:"engine"`

	Connectors struct {
		GOCDB struct {
			Address string `yaml:"address"`
		} `yaml:"gocdb"`
	} `yaml:"connectors"`
}

type MentixConfig struct {
	appDir string

	Settings mentixSettings
}

func (config *MentixConfig) initialize(appDir string) {
	config.appDir = appDir

	// Set default values
	config.Settings.Core.Logging.Enabled = true
	config.Settings.Core.Logging.Directory = config.ResolvePath(FN_LogsDir, "")
	config.Settings.Core.Logging.Level = logging.LogLevelInfo
}

func (config *MentixConfig) Save(configFilename string) error {
	// Create the configuration file and encode it using a YAML decoder
	file, err := os.Create(configFilename)
	if err != nil {
		return fmt.Errorf("unable to create config file '%v': %v", configFilename, err)
	}
	defer file.Close()

	encoder := yaml.NewEncoder(file)
	if err := encoder.Encode(&config.Settings); err != nil {
		return fmt.Errorf("unable to encode the configuration: %v", err)
	}

	return nil
}

func (config *MentixConfig) Load(configFilename string) error {
	// If the config file doesn't exist yet, create a default one
	_, err := os.Stat(configFilename)
	if os.IsNotExist(err) {
		if err := config.createDefaultConfig(configFilename); err != nil {
			return fmt.Errorf("no Mentix configuration found: %v", err)
		}
	}

	// Open the configuration file and decode it using a YAML decoder
	file, err := os.Open(configFilename)
	if err != nil {
		return fmt.Errorf("unable to load config file '%v': %v", configFilename, err)
	}
	defer file.Close()

	decoder := yaml.NewDecoder(file)
	if err := decoder.Decode(&config.Settings); err != nil {
		return fmt.Errorf("unable to decode the configuration: %v", err)
	}

	return nil
}

func (config *MentixConfig) createDefaultConfig(configFilename string) error {
	if err := config.Save(configFilename); err != nil {
		return fmt.Errorf("unable to create a default configuration: %v", err)
	} else {
		return nil
	}
}

func (config *MentixConfig) ResolveFilename(filename string) string {
	dir, file := filepath.Split(filename)
	return config.ResolvePath(dir, file)
}

func (config *MentixConfig) SafeResolveFilename(filename string) string {
	dir, file := filepath.Split(filename)
	return config.SafeResolvePath(dir, file)
}

func (config *MentixConfig) ResolvePath(dir string, filename string) string {
	filename = filepath.Join(dir, filename)
	if filepath.IsAbs(filename) {
		return filename
	} else {
		return filepath.Join(config.appDir, filename)
	}
}

func (config *MentixConfig) SafeResolvePath(dir string, filename string) string {
	resolvedFilename := config.ResolvePath(dir, filename)

	// Create directory tree
	if len(filename) == 0 { // No filename provided
		os.MkdirAll(resolvedFilename, os.ModePerm)
	} else {
		os.MkdirAll(filepath.Dir(resolvedFilename), os.ModePerm)
	}

	return resolvedFilename
}

func NewMentixConfig(appDir string) *MentixConfig {
	config := new(MentixConfig)
	config.initialize(appDir)
	return config
}
