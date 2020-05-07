/**************************************************************************************************
 * File:   engine.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package engine

import (
	"fmt"

	"github.com/sciencemesh/mentix/connectors"
	"github.com/sciencemesh/mentix/core/config"
	"github.com/sciencemesh/mentix/core/logging"
	"github.com/sciencemesh/mentix/meshdata"
)

type MentixEngine struct {
	config *config.MentixConfig

	meshData *meshdata.MeshData

	connector connectors.Connector
}

func (engine *MentixEngine) initialize(config *config.MentixConfig) error {
	logging.Log().Info("Initializing engine...")

	engine.config = config

	// Try to get a connector with the given ID
	connector, err := connectors.FindConnector(engine.config.Settings.Engine.Connector)
	if err != nil {
		return fmt.Errorf("the desired connector could be found: %v", err)
	}
	engine.connector = connector
	logging.Log().Infof("\t<b>Connector:</> %v", connector.GetName())

	// Activate the connector
	if err := engine.connector.Activate(engine.config); err != nil {
		return fmt.Errorf("unable to activate the connector: %v", err)
	}

	engine.meshData = meshdata.NewMeshData()

	return nil
}

func (engine *MentixEngine) destroy() {
	logging.Log().Info("Engine stopped")
}

func (engine *MentixEngine) Run() error {
	// Destroy the engine automatically after Run() has finished
	defer engine.destroy()

	logging.Log().Info("Engine started")

	return nil
}

func NewMentixEngine(config *config.MentixConfig) (*MentixEngine, error) {
	engine := new(MentixEngine)
	if err := engine.initialize(config); err != nil {
		return nil, fmt.Errorf("unable to initialize the Mentix engine: %v", err)
	}
	return engine, nil
}
