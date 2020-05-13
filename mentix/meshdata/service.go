/**************************************************************************************************
 * File:   service.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package meshdata

type Service struct {
	ServiceEndpoint

	Host                string
	AdditionalEndpoints []*ServiceEndpoint
}

type ServiceType struct {
	Name        string
	Description string
}

type ServiceEndpoint struct {
	Type        *ServiceType
	Name        string
	Path        string
	IsMonitored bool
	Properties  map[string]string
}
