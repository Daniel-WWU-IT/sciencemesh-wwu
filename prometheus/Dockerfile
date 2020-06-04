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

CMD     ["/bin/prometheus", \
            "--config.file", "/etc/prometheus/prometheus.yml", \
            "--storage.tsdb.path", "/prometheus", \
            "--web.console.libraries", "/usr/share/prometheus/console_libraries", \
            "--web.console.templates", "/usr/share/prometheus/consoles", \
            "--web.external-url", "https://sciencemesh-test.uni-muenster.de/prometheus", \
            "--web.route-prefix", "/" \
        ]
