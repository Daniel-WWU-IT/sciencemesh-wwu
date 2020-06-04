# Dockerfile -- Customized Prometheus image
#
# Author:   Daniel Mueller/University of Muenster (daniel.mueller@uni-muenster.de)
# Date:     2020-06-04
# Version:  1.0

FROM    prom/prometheus
LABEL   maintainer "daniel.mueller@uni-muenster.de"
LABEL   description "Customized Prometheus"

# Copy all configuration files into the container
COPY    config/ /etc/prometheus
