#!/bin/bash

set -euxo pipefail

hash terraform pgbench
source vars.env

terraform init
terraform apply --auto-approve

export PGPASSWORD=$TF_VAR_PGBENCH_DB_PASS
time pgbench -h $TF_VAR_PGBENCH_DB_HOST -U $TF_VAR_PGBENCH_DB_USER -i -s 10000 pgbench
time pgbench -h $TF_VAR_PGBENCH_DB_HOST -U $TF_VAR_PGBENCH_DB_USER -c 4 -t 100000 pgbench

terraform destroy --auto-approve
