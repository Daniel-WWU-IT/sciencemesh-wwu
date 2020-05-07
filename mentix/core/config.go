/**************************************************************************************************
 * File:   config.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package core

import (
	"fmt"
	"os"

	"github.com/sciencemesh/mentix/core/logging"

	"gopkg.in/yaml.v2"
)

type mentixConfig struct {
	Core struct {
		Logging struct {
			Enabled   bool   `yaml:"enabled"`
			Directory string `yaml:"directory"`
			Level     int    `yaml:"level"`
		} `yaml:"logging"`
	} `yaml:"core"`
}

func (config *mentixConfig) reset(app *mentixApp) {
	// Set default values
	config.Core.Logging.Enabled = true
	config.Core.Logging.Directory = app.ResolvePath(fn_logsDir, "")
	config.Core.Logging.Level = logging.LogLevelInfo
}

func (config *mentixConfig) Save(configFilename string) error {
	// Create the configuration file and encode it using a YAML decoder
	file, err := os.Create(configFilename)
	if err != nil {
		return fmt.Errorf("unable to create config file '%v': %v", configFilename, err)
	}
	defer file.Close()

	encoder := yaml.NewEncoder(file)
	if err := encoder.Encode(config); err != nil {
		return fmt.Errorf("unable to encode the configuration: %v", err)
	}

	return nil
}

func (config *mentixConfig) Load(configFilename string) error {
	// If the config file doesn't exist yet, create a default one
	_, err := os.Stat(configFilename)
	if os.IsNotExist(err) {
		config.createDefaultConfig(configFilename)
	}

	// Open the configuration file and decode it using a YAML decoder
	file, err := os.Open(configFilename)
	if err != nil {
		return fmt.Errorf("unable to load config file '%v': %v", configFilename, err)
	}
	defer file.Close()

	decoder := yaml.NewDecoder(file)
	if err := decoder.Decode(config); err != nil {
		return fmt.Errorf("unable to decode the configuration: %v", err)
	}

	return nil
}

func (config *mentixConfig) createDefaultConfig(configFilename string) error {
	if err := config.Save(configFilename); err != nil {
		return fmt.Errorf("unable to create a default configuration: %v", err)
	} else {
		return nil
	}
}

func newMentixConfig(app *mentixApp) *mentixConfig {
	config := new(mentixConfig)
	config.reset(app)
	return config
}
