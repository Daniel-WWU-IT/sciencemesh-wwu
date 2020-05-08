/**************************************************************************************************
 * File:   types
 * Date:   2020-05-08
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package gocdb

type Extension struct {
	Key   string `xml:"KEY"`
	Value string `xml:"VALUE"`
}

type Extensions struct {
	Extensions []*Extension `xml:"EXTENSION"`
}

type ServiceType struct {
	Name        string `xml:"SERVICE_TYPE_NAME"`
	Description string `xml:"SERVICE_TYPE_DESC"`
}

type ServiceTypes struct {
	Types []*ServiceType `xml:"SERVICE_TYPE"`
}

type Site struct {
	ShortName    string     `xml:"SHORT_NAME"`
	OfficialName string     `xml:"OFFICIAL_NAME"`
	Description  string     `xml:"SITE_DESCRIPTION"`
	Homepage     string     `xml:"HOME_URL"`
	Email        string     `xml:"CONTACT_EMAIL"`
	Domain       string     `xml:"DOMAIN>DOMAIN_NAME"`
	Extensions   Extensions `xml:"EXTENSIONS"`
}

type Sites struct {
	Sites []*Site `xml:"SITE"`
}

type ServiceEndpoint struct {
	Name        string     `xml:"NAME"`
	URL         string     `xml:"URL"`
	Type        string     `xml:"INTERFACENAME"`
	IsMonitored string     `xml:"ENDPOINT_MONITORED"`
	Extensions  Extensions `xml:"EXTENSIONS"`
}

type ServiceEndpoints struct {
	Endpoints []*ServiceEndpoint `xml:"ENDPOINT"`
}

type Service struct {
	Host        string           `xml:"HOSTNAME"`
	Type        string           `xml:"SERVICE_TYPE"`
	IsMonitored string           `xml:"NODE_MONITORED"`
	URL         string           `xml:"URL"`
	Endpoints   ServiceEndpoints `xml:"ENDPOINTS"`
	Extensions  Extensions       `xml:"EXTENSIONS"`
}

type Services struct {
	Services []*Service `xml:"SERVICE_ENDPOINT"`
}
