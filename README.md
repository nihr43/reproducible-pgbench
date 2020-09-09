# reproducable-pgbench

This project is a place for me to track my own testing of postgres installations on varying hardware.

We use terraform to deploy a new database within a postgres installation, run `pgbench` on it, and clean up afterward.

See vars.env for configuration, then run `bash run.sh`.

## results

| cpu					| disk					| ram	| net			| OS		| notes			| load time	| tps		|
|---					|---					|---	|---			|---		|---			|---		|---		|
| AMD Opteron(tm) Processor 6262 HE	| 4 3-disk raidz, 7200rpm 1TB each	| 8gb	| 2 1000BASE-T lacp	| FreeBSD 12.1	| lz4,noatime,128k	| 91m5.090s	| 73.196155	|
