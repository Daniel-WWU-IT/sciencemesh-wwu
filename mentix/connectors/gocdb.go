/**************************************************************************************************
 * File:   gocdb
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package connectors

import (
	"encoding/xml"
	"fmt"
	"strings"

	"github.com/sciencemesh/mentix/connectors/gocdb"
	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/env/config"
	"github.com/sciencemesh/mentix/meshdata"
	"github.com/sciencemesh/mentix/network"
)

type GOCDBConnector struct {
	BaseConnector

	gocdbAddress string
}

const (
	defaultScope = "SM"
)

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
	meshData := new(meshdata.MeshData)

	// Query all data from GOCDB
	if err := connector.queryServiceTypes(meshData); err != nil {
		return nil, fmt.Errorf("could not query service types: %v", err)
	}

	if err := connector.querySites(meshData); err != nil {
		return nil, fmt.Errorf("could not query sites: %v", err)
	}

	for _, site := range meshData.Sites {
		// Get services associated with the current site
		if err := connector.queryServices(meshData, site); err != nil {
			return nil, fmt.Errorf("could not query services of site '%v': %v", site.Name, err)
		}
	}

	return meshData, nil
}

func (connector *GOCDBConnector) getScope() string {
	scope := connector.environment.Config().Connectors.GOCDB.Scope
	if len(scope) == 0 {
		scope = defaultScope
	}
	return scope
}

func (connector *GOCDBConnector) query(v interface{}, method string, isPrivate bool, hasScope bool, params network.URLParams) error {
	var scope string
	if hasScope {
		scope = connector.getScope()
	}

	// Get the data from GOCDB
	data, err := gocdb.QueryGOCDB(connector.environment.Config().Connectors.GOCDB.Address, method, isPrivate, scope, params)
	if err != nil {
		return err
	}

	// Unmarshal it
	if err := xml.Unmarshal(data, v); err != nil {
		return fmt.Errorf("unable to unmarshal data: %v", err)
	}

	return nil
}

func (connector *GOCDBConnector) queryServiceTypes(meshData *meshdata.MeshData) error {
	connector.environment.Log().Debug("con", "Querying service types")

	var serviceTypes gocdb.ServiceTypes
	if err := connector.query(&serviceTypes, "get_service_types", false, false, network.URLParams{}); err != nil {
		return err
	}

	// Copy retrieved data into the mesh data
	meshData.ServiceTypes = nil
	for _, serviceType := range serviceTypes.Types {
		meshData.ServiceTypes = append(meshData.ServiceTypes, &meshdata.ServiceType{
			Name:        serviceType.Name,
			Description: serviceType.Description,
		})
	}
	connector.environment.Log().Debugf("con", "%v service type(s) retrieved", len(meshData.ServiceTypes))

	return nil
}

func (connector *GOCDBConnector) querySites(meshData *meshdata.MeshData) error {
	connector.environment.Log().Debug("con", "Querying sites")

	var sites gocdb.Sites
	if err := connector.query(&sites, "get_site", false, true, network.URLParams{}); err != nil {
		return err
	}

	// Copy retrieved data into the mesh data
	meshData.Sites = nil
	for _, site := range sites.Sites {
		meshsite := &meshdata.Site{
			Name:         site.ShortName,
			FullName:     site.OfficialName,
			Organization: "",
			Domain:       site.Domain,
			Homepage:     site.Homepage,
			Email:        site.Email,
			Description:  site.Description,
			Services:     nil,
			Properties:   connector.extensionsToMap(&site.Extensions),
		}
		meshData.Sites = append(meshData.Sites, meshsite)
	}
	connector.environment.Log().Debugf("con", "%v site(s) retrieved", len(meshData.Sites))

	return nil
}

func (connector *GOCDBConnector) queryServices(meshData *meshdata.MeshData, site *meshdata.Site) error {
	connector.environment.Log().Debugf("con", "Querying services of site '%v'", site.Name)

	var services gocdb.Services
	if err := connector.query(&services, "get_service", false, true, network.URLParams{"sitename": site.Name}); err != nil {
		return err
	}

	// Copy retrieved data into the mesh data
	site.Services = nil
	for _, service := range services.Services {
		// Assemble additional endpoints
		var endpoints []*meshdata.ServiceEndpoint
		for _, endpoint := range service.Endpoints.Endpoints {
			endpoints = append(endpoints, &meshdata.ServiceEndpoint{
				Type:        connector.findServiceType(meshData, endpoint.Type),
				Name:        endpoint.Name,
				Path:        endpoint.URL,
				IsMonitored: strings.EqualFold(endpoint.IsMonitored, "Y"),
				Properties:  connector.extensionsToMap(&endpoint.Extensions),
			})
		}

		// Add the service to the site
		site.Services = append(site.Services, &meshdata.Service{
			ServiceEndpoint: meshdata.ServiceEndpoint{
				Type:        connector.findServiceType(meshData, service.Type),
				Name:        fmt.Sprintf("%v - %v", service.Host, service.Type),
				Path:        "",
				IsMonitored: strings.EqualFold(service.IsMonitored, "Y"),
				Properties:  connector.extensionsToMap(&service.Extensions),
			},
			Host:                service.Host,
			AdditionalEndpoints: endpoints,
		})
	}
	connector.environment.Log().Debugf("con", "%v service(s) retrieved", len(site.Services))

	return nil
}

func (connector *GOCDBConnector) findServiceType(meshData *meshdata.MeshData, name string) *meshdata.ServiceType {
	for _, serviceType := range meshData.ServiceTypes {
		if strings.EqualFold(serviceType.Name, name) {
			return serviceType
		}
	}

	// If the service type doesn't exist, create a default one
	return &meshdata.ServiceType{Name: name, Description: ""}
}

func (connector *GOCDBConnector) extensionsToMap(extensions *gocdb.Extensions) map[string]string {
	properties := make(map[string]string)
	for _, ext := range extensions.Extensions {
		properties[ext.Key] = ext.Value
	}
	return properties
}

func (connector *GOCDBConnector) GetName() string {
	return "GOCDB"
}

func (connector *GOCDBConnector) printInfo() {
	connector.environment.Log().Infof("con", "GOCDB address: %v", connector.gocdbAddress)
}

func init() {
	registerConnector(config.ConnectorID_GOCDB, &GOCDBConnector{})
}
