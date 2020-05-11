/**************************************************************************************************
 * File:   config.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package config

import (
	"fmt"
	"os"

	"gopkg.in/yaml.v2"
)

type settingsDefaulter func(config *Config) error

type Config struct {
	General struct {
		Logging struct {
			Enabled   bool   `yaml:"enabled"`
			Directory string `yaml:"directory"`
			Level     int    `yaml:"level"`
		} `yaml:"logging"`

		Network struct {
			AllowInsecure bool `yaml:"allow-insecure"`
		} `yaml:"network"`
	} `yaml:"general"`

	Engine struct {
		Connector      string   `yaml:"connector"`
		Exporters      []string `yaml:"exporters"`
		UpdateInterval string   `yaml:"update-interval"`
	} `yaml:"engine"`

	Connectors struct {
		GOCDB struct {
			Address string `yaml:"address"`
			Scope   string `yaml:"scope"`
		} `yaml:"gocdb"`
	} `yaml:"connectors"`

	Exporters struct {
		WebAPI struct {
			Port uint `yaml:"port"`
		} `yaml:"webapi"`

		PrometheusFileSD struct {
			OutputFile string `yaml:"output-file"`
		} `yaml:"prom-filesd"`
	} `yaml:"exporters"`
}

func (config *Config) initialize(defaulter settingsDefaulter) error {
	if err := defaulter(config); err != nil {
		return fmt.Errorf("unable to apply default settings: %v", err)
	}

	return nil
}

func (config *Config) Save(configFilename string) error {
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

func (config *Config) Load(configFilename string) error {
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
	if err := decoder.Decode(config); err != nil {
		return fmt.Errorf("unable to decode the configuration: %v", err)
	}

	return nil
}

func (config *Config) createDefaultConfig(configFilename string) error {
	if err := config.Save(configFilename); err != nil {
		return fmt.Errorf("unable to create a default configuration: %v", err)
	} else {
		return nil
	}
}

func NewConfig(defaulter settingsDefaulter) (*Config, error) {
	config := new(Config)
	if err := config.initialize(defaulter); err != nil {
		return nil, fmt.Errorf("unable to initialize configuraton: %v", err)
	}

	return config, nil
}
