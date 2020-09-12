# reproducable-pgbench

This project is a place for me to track my own testing of postgres installations on varying hardware.

We use terraform to deploy a new database within a postgres installation, run `pgbench` on it, and clean up afterward.

See vars.env for configuration, then run `bash run.sh`.

Postgres is `postgresql12-server` as provided by pkg in FreeBSD.
Test and client system are connected to the same physical PHY on a procurve 1800-24g unless noted.

`-s 10000` was chosen as this is about 1 billion rows.
`-c 16` was chosen as this was where the curve just started to flatten out on the initial test system, with regard to the effect of client count on tps.

The first few "default parameters" tests were intentionally repeated to validate consistency in the test method.

## results

| cpu					| disk					| ram	| net				| OS		| zfs parameters				| compress ratio	| load time	| latency	| tps		|
|---					|---					|---	|---				|---		|---						|---			|---		|---		|---		|
| Intel(R) Atom(TM) CPU D525		| this is the test client		| 8gb	| 2 1000BASE-T lacp mtu 9000	| Alpine 3.12	|						|			|		|		|		|
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  |						|			| 120m39.281s	| 157.043 ms	| 101.883033	|
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  |                                               |			|               |               |		|
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  |                                               |           		|               |               |		|
