#!/usr/bin/bash
docker exec -it $1 mysqldump -u root -poihwnthnwent7u2 --databases gocdb > ./sql/01-gocdb_data.sql
