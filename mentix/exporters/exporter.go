/**************************************************************************************************
 * File:   exporter.go
 * Date:   2020-05-11
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package exporters

import (
	"fmt"
	"sync"

	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/meshdata"
)

var (
	registeredExporters = map[string]Exporter{}
)

type Exporter interface {
	Activate(environ *env.Environment) error
	Start() error
	Stop()

	UpdateMeshData(*meshdata.MeshData) error

	GetName() string
}

type BaseExporter struct {
	environment *env.Environment

	meshData *meshdata.MeshData
	locker   sync.RWMutex
}

type performFunc = func() error

func (exporter *BaseExporter) Activate(environ *env.Environment) error {
	if environ == nil {
		return fmt.Errorf("no environment provided")
	}
	exporter.environment = environ

	return nil
}

func (exporter *BaseExporter) Start() error {
	return nil
}

func (exporter *BaseExporter) Stop() {

}

func (exporter *BaseExporter) UpdateMeshData(meshData *meshdata.MeshData) error {
	// Update the stored mesh data
	if err := exporter.storeMeshData(meshData); err != nil {
		return fmt.Errorf("unable to store the mesh data: %v", err)
	}

	return nil
}

func (exporter *BaseExporter) storeMeshData(meshData *meshdata.MeshData) error {
	exporter.locker.Lock()
	defer exporter.locker.Unlock()

	// Store the new mesh data by cloning it
	exporter.meshData = meshData.Clone()
	if exporter.meshData == nil {
		return fmt.Errorf("unable to clone the mesh data")
	}

	return nil
}

func registerExporter(id string, exporter Exporter) {
	registeredExporters[id] = exporter
}

func AvailableExporters(environ *env.Environment) ([]Exporter, error) {
	// Try to add all exporters configured in the environment
	var exporters []Exporter
	for _, exporterID := range environ.Config().Engine.Exporters {
		if exporter, ok := registeredExporters[exporterID]; ok {
			exporters = append(exporters, exporter)
		} else {
			return nil, fmt.Errorf("no exporter with ID '%v' registered", exporterID)
		}
	}

	// At least one exporter must be configured
	if len(exporters) == 0 {
		return nil, fmt.Errorf("no exporters available")
	}

	return exporters, nil
}
