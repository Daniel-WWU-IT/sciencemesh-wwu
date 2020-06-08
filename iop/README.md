# IOP
Various files to deploy and run the IOP on the WWU Kubernetes cluster.

## Configuration files and charts
Kubernetes configuration files and Helm charts are provided to deploy all IOP services on the cluster. The IOP charts are mainly based on CESNET's work. Modifications were made to run them on the WWU Kubernetes cluster.

**Note:** These files are not _in-sync_ with the official ScienceMesh charts; they are only meant for testing purposes and to work with the Phoenix web interface.

## Ingress
Configuration files are provided for an nginx ingress server are provided in `ingress`. The files need to be placed in the following directories:

- `nginx.conf: /etc/nginx/`
- `proxy.conf: /etc/nginx/conf.d/`
