# reproducable-pgbench

This project is a place for me to track my own testing of postgres installations on varying hardware.

We use terraform to deploy a new database within a postgres installation, run `pgbench` on it, and clean up afterward.

See vars.env for configuration, then run `bash run.sh`.

Postgres is `postgresql12-server` as provided by pkg in FreeBSD.
Test and client system are connected to the same physical PHY on a procurve 1800-24g unless noted.

## results

| cpu					| disk					| ram	| net				| OS		| zfs parameters				| compress ratio	| load time	| latency	| tps		|
|---					|---					|---	|---				|---		|---						|---			|---		|---		|---		|
| Intel(R) Atom(TM) CPU D525		| this is the test client		| 8gb	| 2 1000BASE-T lacp mtu 9000	| Alpine 3.12	|						|			|		|		|		|
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  |						|			| 119m12.570s	| 397.686 ms	| 160.931054	|
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  |                                               |                       | 118m35.538s   | 404.550 ms    | 158.200296    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | atime=off                                     |                       | 119m10.452s   | 412.056 ms    | 155.318810    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | dedup=on                                      |                       | 145m18.589s   | 582.826 ms    | 109.809834    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=64k                                |                       | 127m48.945s   | 418.054 ms    | 153.090194    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=32k                                |                       | 140m19.040s   | 422.005 ms    | 151.656885    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=16k                                |                       | 140m49.082s   | 457.989 ms    | 139.741475    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=8k                                 |                       | 170m4.927s    | 378.758 ms    | 168.973497    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=4k                                 |                       | 204m52.121s   | 443.694 ms    | 144.243655    |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | primarycache=none                             |                       | 718m43.518s   | 941.934 ms    | 67.945334     |
| AMD Opteron(tm) Processor 6262 HE     | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | primarycache=metadata                         |                       | 622m47.711s   | 707.698 ms    | 90.434000     |
