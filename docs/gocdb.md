# GOCDB documentation
This document contains details about the pecularities of managing sites and services of the ScienceMesh.

## Sites
- **Organization name:** By default, the full name of the site will be used as the organization name; this can be overriden by adding an `ORGANIZATION` property to the site.

## Services
- **Endpoint URLs:** By default, the service URL will consist of the hostname of the service preceded by `https`. To change the endpoint (e.g., to use `http` instead of `https`, to add a port or a path), use the `URL` field of the service. For additional endpoints, the given path can either be a full URL or a relative path in which case the main service endpoint (without any trailing path) will be prepended.
- **Metrics path:** A service has to expose its Prometheus metrics at the `/metrics` endpoint by default; this can be overriden by adding a `METRICS_PATH` property to the service.