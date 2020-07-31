#!/bin/bash
helm install iop sciencemesh/iop \
    --set-file revad.configFiles.revad\\.toml=config/revad.toml \
    --set-file revad.configFiles.users\\.json=config/users.json \
    --set-file revad.configFiles.ocm-providers\\.json=config/ocm-providers.json \
    -f charts/iop.yaml
