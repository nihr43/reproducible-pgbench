variable "PGBENCH_DB_HOST" {}
variable "PGBENCH_DB_USER" {}
variable "PGBENCH_DB_PASS" {}

provider "postgresql" {
  host            = var.PGBENCH_DB_HOST
  port            = 5432
  database        = "postgres"
  username        = var.PGBENCH_DB_USER
  password        = var.PGBENCH_DB_PASS
  sslmode         = "disable"
  connect_timeout = 15
}

resource "postgresql_database" "pgbench" {
  name              = "pgbench"
  owner             = var.PGBENCH_DB_USER
  allow_connections = true
}
