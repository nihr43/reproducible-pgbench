#!/bin/bash

set -euxo pipefail

hash terraform pgbench
source vars.env

terraform init -no-color
terraform apply -auto-approve -no-color

export PGPASSWORD=$TF_VAR_PGBENCH_DB_PASS
time pgbench -h $TF_VAR_PGBENCH_DB_HOST -U $TF_VAR_PGBENCH_DB_USER -i -s 10000 pgbench
pgbench -h $TF_VAR_PGBENCH_DB_HOST -U $TF_VAR_PGBENCH_DB_USER -c 64 -j 4 -T 3600 pgbench

terraform destroy -auto-approve -no-color
