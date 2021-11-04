# GOCDB documentation
This document contains details about the pecularities of managing sites and services of the ScienceMesh.

## Sites
- **Site ID:** Sites are assigned internal, unique and stable IDs which are independent of the internal GOCDB IDs. The property `SITE_ID` is used to hold these and must be set for every site.
- **Organization name:** By default, the full name of the site will be used as the organization name; this can be overriden by adding an `ORGANIZATION` property to the site.

## The REVAD Service
Every site needs to provide an instance of the `REVAD` service. This acts as the main IOP entrypoint and also provides various other critical endpoints. The service URL needs to point to the main URL the IOP can be accessed under (e.g., `https://sciencemesh.uni-muenster.de/iop`); it may not contain any port number. Monitoring needs to always be enabled for this service type.

To properly configure the `REVAD` service, additional endpoints and properties must be provided, as shown below.

### Additional endpoints
The `REVAD` service exposes various additional endpoints that also must be configured properly. Each such endpoint consists of its relative (e.g., `iop/metrics`) or absolute (e.g., `https://iop.uni-muenster.de/metrics`) URL, its name (which must match its type), as well as its interface name, which is interpreted as its type (this means that the endpoint and interface names are identical).

| Name | Description | URL (common value)| Interface | Monitored? |
| ---  | --- | --- | --- | --- |
| **GATEWAY** | Main gRPC endpoint; note that the protocol (`grpc://`) and the gRPC port must _always_ be specified | `grpc://<host>:<port>` | GATEWAY | Yes |
| **METRICS** | Prometheus metrics endpoint | `metrics` | METRICS | Yes |
| **OCM** | OpenCloudMesh endpoint | `ocm` | OCM | No |
| **WEBDAV** | Webdav endpoint | `remote.php/webdav` | WEBDAV | No |

Only the URLs of the endpoints may differ from above common values; all endpoints need to be added, and their names, interfaces and monitoring need to exactly match what is listed above.

### Additional properties
- **API version:** The current API version of the service needs to be specified via the `API_VERSION` property. Note that this property might be removed in future iterations.
