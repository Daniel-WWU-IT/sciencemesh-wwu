/**************************************************************************************************
 * File:   gocdb
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package connectors

import (
	"fmt"

	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/env/config"
	"github.com/sciencemesh/mentix/meshdata"
)

type GOCDBConnector struct {
	BaseConnector

	gocdbAddress string
}

func (connector *GOCDBConnector) Activate(environ *env.Environment) error {
	if err := connector.BaseConnector.Activate(environ); err != nil {
		return err
	}

	// Check and store GOCDB specific settings
	connector.gocdbAddress = environ.Config().Connectors.GOCDB.Address
	if len(connector.gocdbAddress) == 0 {
		return fmt.Errorf("no GOCDB address configured")
	}

	connector.printInfo()
	return nil
}

func (connector *GOCDBConnector) RetrieveMeshData() (*meshdata.MeshData, error) {
	return nil, nil
}

func (connector *GOCDBConnector) GetName() string {
	return "GOCDB"
}

func (connector *GOCDBConnector) printInfo() {
	connector.environment.Log().Infof("\t\tAddress: %v", connector.gocdbAddress)
}

func init() {
	registerConnector(config.ConnectorID_GOCDB, &GOCDBConnector{})
}
