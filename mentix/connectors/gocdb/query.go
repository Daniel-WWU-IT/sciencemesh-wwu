/**************************************************************************************************
 * File:   query.go
 * Date:   2020-05-08
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package gocdb

import (
	"fmt"

	"github.com/sciencemesh/mentix/network"
)

func QueryGOCDB(address string, method string, isPrivate bool, scope string, params network.URLParams) ([]byte, error) {
	// The method must always be specified
	params["method"] = method

	// If a scope was specified, pass it to the endpoint as well
	if len(scope) > 0 {
		params["scope"] = scope
	}

	// GOCDB's public API is located at <gocdb-host>/gocdbpi/public, the private one at <gocdb-host>/gocdbpi/private
	var path string
	if isPrivate {
		path = "/gocdbpi/private"
	} else {
		path = "/gocdbpi/public"
	}

	// Query the data from GOCDB
	data, err := network.ReadEndpoint(address, path, params)
	if err != nil {
		return nil, fmt.Errorf("unable to read GOCDB endpoint: %v", err)
	}

	return data, nil
}
