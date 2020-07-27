# IOP
Various files to deploy and run the IOP on the WWU Kubernetes cluster.

## Configuration files and charts
Kubernetes and Helm configuration files are provided to deploy all IOP services on the cluster.

## Ingress
Configuration files are provided for an nginx ingress server are provided in `ingress`. The files need to be placed in the following directories:

- `nginx.conf: /etc/nginx/`
- `proxy.conf: /etc/nginx/conf.d/`
