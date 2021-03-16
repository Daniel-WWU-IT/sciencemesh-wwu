# IOP
Various files to deploy and run the IOP on the WWU Kubernetes cluster.

Each component can be installed using the corresponding `..._install.sh` and removed by the corresponding `..._remove.sh` script. There is no particular order in which these components must be installed.

## Configuration files and charts
Kubernetes and Helm configuration files are provided to deploy all IOP services on the cluster; they can be found in the `config`, `k8s` and `charts` directories.
