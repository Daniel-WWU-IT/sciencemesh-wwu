#!/usr/bin/bash
cd /var/www/html/gocdb/lib/Doctrine
doctrine orm:schema-tool:drop --force
doctrine orm:schema-tool:create
php deploy/DeployRequiredDataRunner.php requiredData
