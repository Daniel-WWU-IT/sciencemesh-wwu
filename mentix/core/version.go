/**************************************************************************************************
 * File:   version.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package core

import "fmt"

const (
	VersionMajor    = 0
	VersionMinor    = 4
	VersionRevision = 0
	VersionBuild    = 23
)

func GetVersionString() string {
	return fmt.Sprintf("%v.%v.%v", VersionMajor, VersionMinor, VersionRevision)
}

func GetVersionStringWithBuild() string {
	return fmt.Sprintf("%v.%v.%v Build %04d", VersionMajor, VersionMinor, VersionRevision, VersionBuild)
}