/**************************************************************************************************
 * File:   meshdata.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package meshdata

import (
	"encoding/json"
	"fmt"

	"github.com/google/go-cmp/cmp"
	"github.com/mohae/deepcopy"
)

type MeshData struct {
	Sites        []*Site
	ServiceTypes []*ServiceType
}

func (meshData *MeshData) Clear() {
	meshData.Sites = nil
	meshData.ServiceTypes = nil
}

func (meshData *MeshData) ToJSON() (string, error) {
	data, err := json.MarshalIndent(meshData, "", "\t")
	if err != nil {
		return "", fmt.Errorf("unable to marshal the mesh data: %v", err)
	}
	return string(data), nil
}

func (meshData *MeshData) FromJSON(data string) error {
	meshData.Clear()
	if err := json.Unmarshal([]byte(data), meshData); err != nil {
		return fmt.Errorf("unable to unmarshal the mesh data: %v", err)
	}
	return nil
}

func (meshData *MeshData) Clone() *MeshData {
	return deepcopy.Copy(meshData).(*MeshData)
}

func (meshData *MeshData) Compare(other *MeshData) bool {
	return cmp.Equal(meshData, other)
}

func NewMeshData() *MeshData {
	meshData := new(MeshData)
	meshData.Clear()
	return meshData
}
