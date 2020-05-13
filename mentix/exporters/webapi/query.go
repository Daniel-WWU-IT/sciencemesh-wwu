/**************************************************************************************************
 * File:   query.go
 * Date:   2020-05-11
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package webapi

import (
	"encoding/json"
	"fmt"
	"net/url"
	"strings"

	"github.com/sciencemesh/mentix/meshdata"
)

const (
	queryMethodDefault = ""
)

func HandleQuery(meshData *meshdata.MeshData, params url.Values) ([]byte, error) {
	method := params.Get("method")
	switch strings.ToLower(method) {
	case queryMethodDefault:
		return handleDefaultQuery(meshData, params)

	default:
		return []byte{}, fmt.Errorf("unknown API method '%v'", method)
	}
}

func handleDefaultQuery(meshData *meshdata.MeshData, params url.Values) ([]byte, error) {
	// Just return the plain, unfiltered data as JSON
	data, err := json.MarshalIndent(meshData, "", "\t")
	if err != nil {
		return []byte{}, fmt.Errorf("unable to marshal the mesh data: %v", err)
	}

	return data, nil
}
