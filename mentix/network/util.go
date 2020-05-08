/**************************************************************************************************
 * File:   util.go
 * Date:   2020-05-08
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package network

import (
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"path"
)

type URLParams map[string]string

func GenerateURL(baseURL string, basePath string, params URLParams) (*url.URL, error) {
	fullURL, err := url.Parse(baseURL)
	if err != nil {
		return nil, fmt.Errorf("unable to generate URL: base=%v, path=%v, params=%v", baseURL, basePath, params)
	}

	fullURL.Path = path.Join(fullURL.Path, basePath)

	query := make(url.Values)
	for key, value := range params {
		query.Set(key, value)
	}
	fullURL.RawQuery = query.Encode()

	return fullURL, nil
}

func AllowInsecureConnections() {
	http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
}

func ReadEndpoint(baseURL string, path string, params URLParams) ([]byte, error) {
	endpointURL, err := GenerateURL(baseURL, path, params)
	if err != nil {
		return nil, fmt.Errorf("unable to generate endpoint URL: %v", err)
	}

	// Fetch the data and read the body
	resp, err := http.Get(endpointURL.String())
	if err != nil {
		return nil, fmt.Errorf("unable to get data from endpoint: %v", err)
	}

	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	return body, nil
}
