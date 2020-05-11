/**************************************************************************************************
 * File:   engine.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package engine

import (
	"fmt"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	"github.com/sciencemesh/mentix/connectors"
	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/exporters"
	"github.com/sciencemesh/mentix/meshdata"
	"github.com/sciencemesh/mentix/network"
)

const (
	runLoopSleeptime = time.Millisecond * 250
)

type Engine struct {
	environment *env.Environment

	meshData  *meshdata.MeshData
	connector connectors.Connector
	exporters []exporters.Exporter

	updateInterval time.Duration
}

func (engine *Engine) initialize(environ *env.Environment) error {
	if environ == nil {
		return fmt.Errorf("no environment provided")
	}
	engine.environment = environ

	engine.environment.Log().Info("eng", "Initializing engine")

	// Enable insecure connections if configured so
	if engine.environment.Config().General.Network.AllowInsecure {
		network.AllowInsecureConnections()
		engine.environment.Log().Warning("eng", "Insecure connections allowed")
	}

	// Initialize the connector that will be used to gather the mesh data
	if err := engine.initConnector(); err != nil {
		return fmt.Errorf("unable to initialize connector: %v", err)
	}

	// Initialize the exporters
	if err := engine.initExporters(); err != nil {
		return fmt.Errorf("unable to initialize exporters: %v", err)
	}

	// Get the update interval
	duration, err := time.ParseDuration(engine.environment.Config().Engine.UpdateInterval)
	if err != nil {
		// If the duration can't be parsed, default to one hour
		duration = time.Hour
	}
	engine.updateInterval = duration
	engine.environment.Log().Infof("eng", "Update interval: %v", duration)

	// Create empty mesh data
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

func (engine *Engine) initExporters() error {
	// Use all exporters exposed by the exporters package
	exporters, err := exporters.AvailableExporters(engine.environment)
	if err != nil {
		return fmt.Errorf("unable to get registered exporters: %v", err)
	}
	var names []string
	for _, exporter := range exporters {
		names = append(names, exporter.GetName())
	}
	engine.exporters = exporters
	engine.environment.Log().Infof("eng", "Exporters: %v", strings.Join(names, "; "))

	// Activate all exporters
	for _, exporter := range engine.exporters {
		if err := exporter.Activate(engine.environment); err != nil {
			return fmt.Errorf("unable to activate exporter '%v': %v", exporter.GetName(), err)
		}
	}

	return nil
}

func (engine *Engine) startExporters() error {
	// Start all exporters
	for _, exporter := range engine.exporters {
		if err := exporter.Start(); err != nil {
			return fmt.Errorf("unable to start exporter '%v': %v", exporter.GetName(), err)
		}
	}

	return nil
}

func (engine *Engine) stopExporters() {
	// Stop all exporters
	for _, exporter := range engine.exporters {
		exporter.Stop()
	}
}

func (engine *Engine) destroy() {
	// Stop all exporters
	engine.stopExporters()

	engine.environment.Log().Info("eng", "Engine stopped")
}

func (engine *Engine) Run() error {
	// Destroy the engine automatically after Run() has finished
	defer engine.destroy()

	engine.environment.Log().Info("eng", "Engine started")

	// Start all exporters; they will be stopped in Engine.destroy
	if err := engine.startExporters(); err != nil {
		return fmt.Errorf("unable to start exporters: %v", err)
	}

	// Enable reacting to termination signals
	signalReceiver := make(chan os.Signal, 1)
	signal.Notify(signalReceiver, syscall.SIGINT, syscall.SIGTERM)

	updateTimestamp := time.Time{}
loop:
	for {
		// Poll the signalReceiver channel; if a signal was received, break the loop, terminating the app gracefully
		select {
		case <-signalReceiver:
			engine.environment.Log().Info("eng", "Received termination signal, quitting")
			break loop

		default:
		}

		// If enough time has passed, retrieve the latest mesh data and update it
		if time.Since(updateTimestamp) >= engine.updateInterval {
			meshData, err := engine.retrieveMeshData()
			if err == nil {
				if err := engine.applyMeshData(meshData); err != nil {
					engine.environment.Log().Errorf("eng", "Failed to apply mesh data: %v", err)
				}
			} else {
				// Log the error, but do nothing otherwise
				engine.environment.Log().Errorf("eng", "Failed to update mesh data: %v", err)
			}

			updateTimestamp = time.Now()
		}

		time.Sleep(runLoopSleeptime)
	}

	return nil
}

func (engine *Engine) retrieveMeshData() (*meshdata.MeshData, error) {
	engine.environment.Log().Info("eng", "Updating mesh data")

	meshData, err := engine.connector.RetrieveMeshData()
	if err != nil {
		return nil, fmt.Errorf("retrieving mesh data failed: %v", err)
	}
	return meshData, nil
}

func (engine *Engine) applyMeshData(meshData *meshdata.MeshData) error {
	if !meshData.Compare(engine.meshData) {
		engine.environment.Log().Info("eng", "Mesh data changed, applying new data")
		engine.meshData = meshData

		for _, exporter := range engine.exporters {
			if err := exporter.UpdateMeshData(meshData); err != nil {
				return fmt.Errorf("unable to update mesh data on exporter '%v': %v", exporter.GetName(), err)
			}
		}
	} else {
		engine.environment.Log().Info("eng", "Mesh data unchanged, skipping")
	}

	return nil
}

func NewEngine(environ *env.Environment) (*Engine, error) {
	engine := new(Engine)
	if err := engine.initialize(environ); err != nil {
		return nil, fmt.Errorf("unable to initialize engine: %v", err)
	}
	return engine, nil
}
