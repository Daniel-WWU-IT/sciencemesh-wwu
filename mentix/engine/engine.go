/**************************************************************************************************
 * File:   engine.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package engine

import (
	"fmt"

	"github.com/sciencemesh/mentix/connectors"
	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/meshdata"
	"github.com/sciencemesh/mentix/network"
)

type Engine struct {
	environment *env.Environment

	meshData *meshdata.MeshData

	connector connectors.Connector
}

func (engine *Engine) initialize(environ *env.Environment) error {
	if environ == nil {
		return fmt.Errorf("no environment provided")
	}
	engine.environment = environ

	engine.environment.Log().Info("eng", "Initializing engine...")

	// Enable insecure connections if configured so
	if engine.environment.Config().Network.AllowInsecure {
		network.AllowInsecureConnections()
		engine.environment.Log().Warning("eng", "Insecure connections allowed")
	}

	// Initialize the connector that will be used to gather the mesh data
	if err := engine.initConnector(); err != nil {
		return fmt.Errorf("unable to initialize connector: %v", err)
	}

	// Create the mesh data
	engine.meshData = meshdata.NewMeshData()

	return nil
}

func (engine *Engine) initConnector() error {
	// Try to get a connector with the configured ID
	connector, err := connectors.FindConnector(engine.environment.Config().Engine.Connector)
	if err != nil {
		return fmt.Errorf("the desired connector could be found: %v", err)
	}
	engine.connector = connector
	engine.environment.Log().Infof("eng", "Connector: %v", connector.GetName())

	// Activate the selected connector
	if err := engine.connector.Activate(engine.environment); err != nil {
		return fmt.Errorf("unable to activate connector: %v", err)
	}

	return nil
}

func (engine *Engine) destroy() {
	engine.environment.Log().Info("eng", "Engine stopped")
}

func (engine *Engine) Run() error {
	// Destroy the engine automatically after Run() has finished
	defer engine.destroy()

	engine.environment.Log().Info("eng", "Engine started")

	// TODO: Loop da loop
	meshData, err := engine.retrieveMeshData()
	if err == nil {
		engine.applyMeshData(meshData)
	} else {
		// Log the error, but do nothing otherwise
		engine.environment.Log().Errorf("eng", "Failed to update the mesh data: %v", err)
	}

	return nil
}

func (engine *Engine) retrieveMeshData() (*meshdata.MeshData, error) {
	engine.environment.Log().Info("eng", "Updating mesh data...")

	meshData, err := engine.connector.RetrieveMeshData()
	if err != nil {
		return nil, fmt.Errorf("retrieving the mesh data failed: %v", err)
	}
	return meshData, nil
}

func (engine *Engine) applyMeshData(meshData *meshdata.MeshData) {
	engine.meshData = meshData
}

func NewEngine(environ *env.Environment) (*Engine, error) {
	engine := new(Engine)
	if err := engine.initialize(environ); err != nil {
		return nil, fmt.Errorf("unable to initialize engine: %v", err)
	}
	return engine, nil
}
