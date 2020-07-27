# IOP
Various files to deploy and run the IOP on the WWU Kubernetes cluster.

Each component can be installed using the corresponding `..._install.sh` and removed by the corresponding `..._remove.sh` script. There is no particular order in which these components must be installed.

## Configuration files and charts
Kubernetes and Helm configuration files are provided to deploy all IOP services on the cluster; they can be found in the `k8s` and `charts` directories.

## Ingress
Configuration files are provided for an **nginx** ingress server are provided in `ingress`. The files need to be placed in the following directories:

- `nginx.conf: /etc/nginx/`
- `proxy.conf: /etc/nginx/conf.d/`

This ingress server runs outside of the actual Kubernetes cluster and simply redirects (nearly) all incoming trafik to the ingress server running in the cluster.

In Kubernetes, the ingress is managed by **Traefik** and is configured via `ingress.yaml`.
