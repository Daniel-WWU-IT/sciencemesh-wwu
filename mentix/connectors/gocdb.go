/**************************************************************************************************
 * File:   gocdb
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package connectors

import (
	"fmt"

	"github.com/sciencemesh/mentix/core/config"
	"github.com/sciencemesh/mentix/core/logging"
	"github.com/sciencemesh/mentix/meshdata"
)

type GOCDBConnector struct {
	Connector

	gocdbAddress string
}

const (
	GOCDBConnectorID = "gocdb"
)

func (connector *GOCDBConnector) Activate(config *config.MentixConfig) error {
	connector.gocdbAddress = config.Settings.Connectors.GOCDB.Address
	if len(connector.gocdbAddress) == 0 {
		return fmt.Errorf("no GOCDB address configured")
	}

	connector.printInfo()
	return nil
}

func (connector *GOCDBConnector) GetName() string {
	return "GOCDB"
}

func (connector *GOCDBConnector) RetrieveMeshData() (*meshdata.MeshData, error) {
	return nil, nil
}

func (connector *GOCDBConnector) printInfo() {
	logging.Log().Infof("\t\tAddress: %v", connector.gocdbAddress)
}

func NewGOCDBConnector() *GOCDBConnector {
	return &GOCDBConnector{}
}

func init() {
	registerConnector(GOCDBConnectorID, &GOCDBConnector{})
}
