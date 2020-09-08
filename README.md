# reproducable-pgbench

This project is a place for me to track my own testing of postgres installations on varying hardware.

We use terraform to deploy a new database within a postgres installation, run `pgbench` on it, and clean up afterward.

See vars.env for configuration, then run `bash run.sh`.
