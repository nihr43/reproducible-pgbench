# reproducable-pgbench

This project is a place for me to track my own testing of postgres installations on varying hardware.

We use terraform to deploy a new database within a postgres installation, run `pgbench` on it, and clean up afterward.

See vars.env for configuration, then run `bash run.sh`.

## results

| cpu					| disk					| ram	| net			| OS		| notes						| load time	| tps		|
|---					|---					|---	|---			|---		|---						|---		|---		|
| AMD Opteron(tm) Processor 6262 HE	| 12 7200rpm 1TB, raidz10 groups of 3	| 8gb	| 2 1000BASE-T lacp	| FreeBSD 12.1	| compression=lz4,atime=off,recordsize=128k	| 91m5.090s	| 73.196155	|
| AMD Opteron(tm) Processor 6262 HE	| 12 7200rpm 1TB, raidz10 groups of 3	| 8gb	| 2 1000BASE-T lacp	| FreeBSD 12.1	| compression=off,atime=off,recordsize=128k	| 114m2.774s	| 54.447264	|
