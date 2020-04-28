# GOCDB Docker Container
Docker files to provide a containerized version of GOCDB (https://wiki.egi.eu/wiki/GOCDB/Documentation_Index) for the CS3MESH4EOSC project.

## Installation
Simply build and run the containers via _docker-compose_:

- docker-compose build && docker-compose up -d

This will launch two containers, one for the database and one for the webserver.

### Running in Kubernetes
Simple Kubernetes configuration files are provided in _k8s_. Note that the deployments are configured to never pull images, so the containers have to be built beforehand.

## Configuration
Configuration is usually not necessary. If you need to adjust the webserver configuration, modify the corresponding files in _webserver/config_ and rebuild.

## Usage
- The GOCDB frontend can be reached at: [/gocdb](http://localhost/gocdb)
- The public API can be reached at: [/gocdbpi/public](http://localhost/gocdbpi/public)
- The private API can be reached at: [/gocdbpi/private](http://localhost/gocdbpi/private)

## Notes
The provided container is for testing purposes only. It is neither efficient nor secure. Not every detail of GOCDB was tested. If you encounter any problems, feel free to contact me at [daniel.mueller@uni-muenster.de](mailto:daniel.mueller@uni-muenster.de).
