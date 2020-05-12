# Mentix
Mentix (_**Me**sh E**nti**ty E**x**porter_) is a daemon written in Go to read mesh topology data from a source (e.g., a GOCDB instance) and export it to various targets like Prometheus.

## Overview
Mentix acts as a bridge between a mesh data topology provider like [GOCDB](https://wiki.egi.eu/wiki/GOCDB/Documentation_Index) and its data consumers. It hides any backend-details and exports data in multiple ways without the user needing to worry about the actual source of the data.

Mentix runs as a background service. It regularely pulls the mesh data from its source, checks if the data have changed since the last pull and exports it if needed.
 
 ## Installation
 Mentix comes as a Go module. The easiest way to build it is to clone this repository into a directory outside of `GOPATH` and run `go build -i -o="."` in that directory. This will create the Mentix binary directly in the just-cloned directory.
 
 **Note:** To specify a different directory, modify the `-o`parameter accordingly. If it is omitted, the binary will be placed into `$GOPATH\bin` by default.
 
 ## Configuration
 Mentix needs to be properly configured before it can be used. This is done by editing the `mentix.yaml` file; if you have placed the Mentix binary in a different directory, you first need to copy the provided `mentix.yaml` file into that directory (**note:** if no configuration is present, a default one will be created; you will need to modify this, however, just as well).

The [provided configuration](mentix.yaml) file contains plenty of comments that will guide you through the very easy configuration steps.

If you ever want to use a different configuration file, you can use the `--config` command-line parameter:
    
    mentix --config "/etc/my_mentix_conf.yaml"

## Usage
Mentix runs as a background service, so no further actions are required once it has been started. New data will from now on be pulled from the configured data source on a regular basis and exported to one or more targets. A description of all supported data sources and exporters follows below.

## Supported data sources
Mentix is decoupled from the actual source of the mesh data by using a so-called _connector_. A connector is used to gather the data from a certain source, which are then converted into Mentix' own internal format. This means that no matter which source is used, the data exported by Mentix always have the same format.

Currently, only one such source is supported:

### GOCDB 
The [GOCDB](https://wiki.egi.eu/wiki/GOCDB/Documentation_Index) is a database specifically designed to organize the topology of a mesh of distributed sites and services. In order to use GOCDB with Mentix, its instance address has to be set in the configuration file:
    
    connectors:
      gocdb:
        address: "http://gocdb.example.com"

**Note:** Since protected-level APIs are used to gather site information from GOCDB, Mentix has to be able to access these to function properly.

## Supported exporters
Mentix exposes its gathered data by using one or more _exporters_. Such exporters can, for example, write the data to a file in a specific format, or offer the data via an HTTP endpoint.

Currently, the following exporters are supported:

### WebAPI
Mentix exposes its data via a web-based HTTP endpoint using the `webapi` exporter. This exporter creates a web server that can be queried by consumers. By default, it runs on port 9600, but this can be changed in the Mentix configuration:

    exporters:
      webapi:
        port: 4711
        
Data can then be retrieved by issueing a `GET` on the `/` or `/query` endpoints (both are currently equal):

    curl http://mentix.example.com:4711/query
    
The web API currently doesn't support any parameters but will most likely be extended in the future. 

### Prometheus File Service Discovery
[Prometheus](https://prometheus.io/) supports discovering new services it should monitor via external configuration files (hence, this is called _file-based service discovery_). Mentix can create such files using the `prom-filesd` exporter. To use this exporter, you have to specify the target output file in the Mentix configuration:

    exporters:
      prom-filesd:      
        output-file: /usr/share/prom/sciencemesh_services.json

You also have to set up the discovery service in Prometheus by adding a scrape configuration like the following example to the Prometheus configuration:

    scrape_configs:
      - job_name: 'sciencemesh'
        file_sd_configs:
          - files:
             - '/usr/share/prom/sciencemesh_services.json'
            
For more information, visit the official [Prometheus documentation](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#file_sd_config).

## Some notes
Mentix is still in beta. If you encounter any problems, have questions or suggestions, feel free to contact me at [daniel.mueller@uni-muenster.de](mailto:daniel.mueller@uni-muenster.de). Also note that the stand-alone daemon is planned to be integrated into [Reva](https://reva.link/) in the future.
