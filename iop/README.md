# IOP
Various files to deploy and run the IOP on the WWU Kubernetes cluster.

Each component can be installed using the corresponding `..._install.sh`, updated via `..._update.sh`, and removed by the corresponding `..._remove.sh` script. There is no particular order in which these components must be installed.

## Configuration files and charts
Kubernetes and Helm configuration files are provided to deploy all IOP services on the cluster; they can be found in the `config`, `k8s` and `charts` directories.

## Deployment notes
For some components, a few extra steps after deployment must be taken.

### Grafana
Since Grafana cannot be fully provisioned, several extra steps are necessary:

- Mark the following dashboards as favorites:
  - `ScienceMesh/General statistics`
  - `SciecenMesh Health/Health monitoring`
- Remove the `Viewer` role from the `ScienceMesh Health` folder; this will make all health monitoring dashboards non-public
- Modify the following preferences:
  - Set the organization name to `ScienceMesh`
  - Select `ScienceMesh/General statistics` as the home dashboard
