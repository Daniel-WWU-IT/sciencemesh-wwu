# GOCDB documentation
This document contains details about the pecularities of managing sites and services of the ScienceMesh.

## Sites
- **Site ID:** Sites are assigned internal, unique and stable IDs which are independent of the internal GOCDB IDs. The property `SITE_ID` is used to hold these and must be set for every site.
- **Organization name:** By default, the full name of the site will be used as the organization name; this can be overriden by adding an `ORGANIZATION` property to the site.

## Services
- **Endpoint URLs:** By default, the service URL will consist of the hostname of the service preceded by `https`. To change the endpoint (e.g., to use `http` instead of `https`, to add a port or a path), use the `URL` field of the service. For additional endpoints, the given path can either be a full URL or a relative path in which case the main service endpoint URL will be prepended. If the relative path starts with a `/`, the path will replace the main endpoint path; otherwise, the path will be appended.
- **Additional endpoints:** The full name of the service offered at an additional endpoint needs to be specified in the `Interface name` field; it should consist of the main service name followed by a dash and the subordinate service name.
- **Metrics path:** A service has to expose its Prometheus metrics at the `/metrics` endpoint by default; this can be overriden by adding a `METRICS_PATH` property to the service.
- **gRPC port:** If a service can be reached via gRPC, its port can be set via the `GRPC_PORT` property.
- **Health checking:** If a service should be checked for its health status, the property `ENABLE_HEALTH_CHECKS` has to be explicitly set to `true`.
- **API version:** An API version of a service can be specified via the `API_VERSION` property.
