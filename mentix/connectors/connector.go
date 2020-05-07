/**************************************************************************************************
 * File:   connector.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package connectors

import (
	"fmt"
	"strings"

	"github.com/sciencemesh/mentix/core/config"
	"github.com/sciencemesh/mentix/meshdata"
)

var (
	registeredConnectors = map[string]Connector{}
)

type Connector interface {
	Activate(config *config.MentixConfig) error

	GetName() string

	RetrieveMeshData() (*meshdata.MeshData, error)
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
