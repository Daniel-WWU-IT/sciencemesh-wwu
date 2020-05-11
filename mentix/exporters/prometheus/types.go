/**************************************************************************************************
 * File:   types.go
 * Date:   2020-05-11
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package prometheus

type ScrapeConfig struct {
	Targets []string          `json:"targets"`
	Labels  map[string]string `json:"labels"`
}

/*
func ScrapeConfigFromGOCDBService(service *gocdb.ServiceEndpoint) (*ScrapeConfig, error) {
	endpoint, err := service.Endpoint()
	if err != nil {
		return nil, fmt.Errorf("unable to get service endpoint: %v", err)
	}

	// Target consists of the target plus port
	target := endpoint.Hostname()
	if port := endpoint.Port(); len(port) > 0 {
		target += fmt.Sprintf(":%v", endpoint.Port())
	}

	// Put the service information into a ScrapeConfig
	config := &ScrapeConfig{
		Targets: []string{target},
		Labels: map[string]string{
			"ngi":     service.NGI,
			"site":    service.Sitename,
			"svctype": service.Type,
		},
	}

	return config, nil
}

// ScrapeConfigFromGOCDBServices creates new ScrapeConfigs from GOCDB service endpoints.
func ScrapeConfigsFromGOCDBServices(services []*gocdb.ServiceEndpoint) ([]*ScrapeConfig, error) {
	var configs []*ScrapeConfig
	for _, service := range services {
		config, err := ScrapeConfigFromGOCDBService(service)
		if err != nil {
			return nil, fmt.Errorf("unable to create a scrape config from service %v: %v", service, err)
		}
		configs = append(configs, config)
	}

	return configs, nil
}
*/
