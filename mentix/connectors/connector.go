/**************************************************************************************************
 * File:   connector.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package connectors

import (
	"fmt"
	"strings"

	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/meshdata"
)

var (
	registeredConnectors = map[string]Connector{}
)

type Connector interface {
	Activate(environ *env.Environment) error
	RetrieveMeshData() (*meshdata.MeshData, error)

	GetName() string
}

type BaseConnector struct {
	environment *env.Environment
}

func (connector *BaseConnector) Activate(environ *env.Environment) error {
	if environ == nil {
		return fmt.Errorf("no environment provided")
	}
	connector.environment = environ

	return nil
}

func FindConnector(connectorID string) (Connector, error) {
	for id, connector := range registeredConnectors {
		if strings.EqualFold(id, connectorID) {
			return connector, nil
		}
	}

	return nil, fmt.Errorf("no connector with ID '%v' registered", connectorID)
}

func registerConnector(id string, connector Connector) {
	registeredConnectors[id] = connector
}
