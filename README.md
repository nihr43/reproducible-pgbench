# reproducible-pgbench

This project is a place for me to track my own testing of postgres installations on varying hardware.

We use terraform to deploy a new database within a postgres installation, run `pgbench` on it, and clean up afterward.

See vars.env for configuration, then run `bash run.sh`.

Postgres is `postgresql12-server-12.3` as provided by pkg in FreeBSD.
Test and client system are connected to the same physical PHY on a procurve 1800-24g unless noted.

The dataset uncompressed is 148G.

## results

| id | cpu			         | disk				         | ram   | net			         | OS            | notes		         			         | load time     | latency       | tps           |
|--- |---			         |---			                 |---    |---			         |---	         |---					                         |---            |---	         |---	         |
| 0  | Intel(R) Atom(TM) CPU D525        |                                       | 8gb   | 2 1000BASE-T lacp mtu 9000    | Alpine 3.12   | this is the test client                                       |	         |	         |	         |
| 1  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  |					                         | 119m12.570s   | 397.686 ms    | 160.931054    |
| 3  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  |                                                               | 118m35.538s   | 404.550 ms    | 158.200296    |
| 4  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | atime=off                                                     | 119m10.452s   | 412.056 ms    | 155.318810    |
| 5  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | dedup=on                                                      | 145m18.589s   | 582.826 ms    | 109.809834    |
| 6  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=64k                                                | 127m48.945s   | 418.054 ms    | 153.090194    |
| 7  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=32k                                                | 140m19.040s   | 422.005 ms    | 151.656885    |
| 8  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=16k                                                | 140m49.082s   | 457.989 ms    | 139.741475    |
| 9  | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=8k                                                 | 170m4.927s    | 378.758 ms    | 168.973497    |
| 10 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | recordsize=4k                                                 | 204m52.121s   | 443.694 ms    | 144.243655    |
| 11 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | primarycache=none                                             | 718m43.518s   | 941.934 ms    | 67.945334     |
| 12 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | primarycache=metadata                                         | 622m47.711s   | 707.698 ms    | 90.434000     |
| 13 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4                                               | 102m36.312s   | 308.860 ms    | 207.213677    |
| 14 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4,redundant_metadata=most                       | 103m25.607s   | 308.453 ms    | 207.486853    |
| 15 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4,checksum=sha512                               | 103m12.669s   | 320.681 ms    | 199.575287    |
| 16 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4, disks moved to SE3016-SAS                    | 103m10.500s   | 312.988 ms    | 204.480903    |
| 17 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4, 256GB MLC SATA2 L2ARC                        | 102m33.225s   | 255.081 ms    | 250.900326    |
| 18 | AMD Opteron(tm) Processor 6262 HE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4, 256GB MLC SATA2 SLOG                         | 96m49.539s    | 173.920 ms    | 367.985629    |
| 19 | AMD Opteron(tm) Processor 6386 SE | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4, 256GB MLC SATA2 SLOG                         | 106m16.895s   | 166.153 ms    | 385.187118    |
| 20 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 8gb   | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4, 200GB SLC SAS1 SLOG                          | 94m3.057s     | 174.798 ms    | 366.137119    |
| 21 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | lz4,SAS1 SLOG,shared_buffers=1G,vfs.zfs.arc_max=7G            | 97m27.818s    | 175.546 ms    | 364.576835    |
| 22 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | lz4,SAS1 SLOG,shared_buffers=4G,vfs.zfs.arc_max=4G            | 97m49.119s    | 284.646 ms    | 224.840734    |
| 23 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | lz4,SAS1 SLOG,shared_buffers=15G,vfs.zfs.arc_max=15G          | 95m29.869s    | 79.830 ms     | 801.706708    |
| 24 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | compression=lz4, 200GB SLC SAS1 SLOG                          | 90m54.044s    | 28.167 ms     | 2272.146411   |
| 25 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | lz4,SAS1 SLOG,SAS1 L2ARC,shared_buffers=1G,vfs.zfs.arc_max=7G | 98m11.046s    | 131.973 ms    | 484.946665    |
| 26 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=512k                                          | 96m45.423s    | 256.797 ms    | 249.223730    |
| 27 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=256k                                          | 97m33.584s    | 204.809 ms    | 312.486764    |
| 28 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=128k                                          | 97m59.789s    | 115.685 ms    | 553.224850    |
| 29 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=64k                                           | 100m37.085s   | 104.425 ms    | 612.882336    |
| 30 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=32k                                           | 104m51.391s   | 79.763 ms     | 802.373890    |
| 31 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=16k                                           | 104m34.523s   | 77.366 ms     | 827.235778    |
| 32 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=8k                                            | 142m54.971s   | 66.507 ms     | 962.301782    |
| 33 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=4k                                            | 177m47.044s   | 134.837 ms    | 474.648572    |
| 34 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=8k, wal_level = minimal                       | 132m0.682s    | 82.438 ms     | 776.343612    |
| 35 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=8k, effective_io_concurrency=12               | 144m6.096s    | 77.891 ms     | 821.659702    |
| 36 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=8k, effective_io_concurrency=6                | 144m44.066s   | 77.628 ms     | 824.440757    |
| 37 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=8k, atime=off, checksum=skein                 | 146m19.902s   | 77.200 ms     | 829.011324    |
| 38 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | [1], recordsize=8k,logbias=throughput,redundant_metadata=most | 137m31.086s   | 162.787 ms    | 393.151201    |
| 39 | Intel(R) Atom(TM) CPU C3858       | 2 SAS1 SLC 200G, striped              | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | shared_buffers=1G,vfs.zfs.arc_max=7G                          | 90m28.187s    | 95.297 ms     | 671.587059    |
| 40 | Intel(R) Atom(TM) CPU C3858       | 2 SAS1 SLC 200G, striped              | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | shared_buffers=1G,vfs.zfs.arc_max=7G,compression=lz4          | 87m54.210s    | 29.424 ms     | 2175.123404   |
| 41 | Intel(R) Atom(TM) CPU C3858       | 2 SAS1 SLC 200G, striped              | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | shared_buffers=1G,vfs.zfs.arc_max=7G, lz4, recordsize=8k      | 114m45.806s   | 27.538 ms     | 2324.021162   |
| 42 | Intel(R) Atom(TM) CPU C3858       | 2 SAS1 SLC 200G, striped              | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | shared_buffers=1G,vfs.zfs.arc_max=7G, ashift=12               | 90m38.562s    | 95.233 ms     | 672.037112    |
| 43 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | shared_buffers=1G,vfs.zfs.arc_max=7G, ashift=12               | 102m38.605s   | 443.347 ms    | 144.356459    |
| 44 | Intel(R) Atom(TM) CPU C3858       | 12 7200rpm 1TB, raidz10 vdevs of 3    | 32gb  | 2 1000BASE-T lacp mtu 9000    | FreeBSD 12.1  | shared_buffers=1G,vfs.zfs.arc_max=7G, ashift=9                | 102m29.447s   | 439.877 ms    | 145.495067    |

_[1] - compression=lz4, 2 x 4gb SLC SAS1 SLOG mirrored, 2 x 128gb SLC SAS1 L2ARC striped, shared_buffers=1G, vfs.zfs.arc_max=7G_

## takeaways

There's a lot of FUD and copypasta on the internet regarding ZFS and Postgres configuration - but rarely any numbers - so here goes...

### recordsize

I'm not sure why tests 6-10 did not show much change with varying recoordsize, but 26-33 clearly show significant impact.  The jump in "load time" is interesting in 31,32 - I suspect this may have something to due with the vacuum step that happens while loading the test data.

### compression

As for compression, there is no reason not to have lz4 enabled while using spinning disks.  For this workload, we see both a performance increase and up to a 9:1 compression ratio.  Test 13 shows a significant improvement over default parameters.

An ARC sample 30-40 minutes into the benchmark:

```
ARC: 18G Total, 4150M MFU, 13G MRU, 563M Anon, 302M Header, 7256K Other
     17G Compressed, 148G Uncompressed, 8.92:1 Ratio
```

A compressratio sample 10-20 minutes into the benchmark:

```
NAME   PROPERTY       VALUE  SOURCE
vault  compressratio  9.02x  -
```

_I would be thrilled to get so much free space and memory on the servers I use at my day job!_

### slog

Second to compression, an array of SLOG devices is essential for a database workload.

```
               capacity     operations    bandwidth
pool        alloc   free   read  write   read  write
----------  -----  -----  -----  -----  -----  -----
vault       30.6G  10.8T    480  2.55K  10.8M  83.8M
  raidz1    6.44G  2.71T    118    546  2.65M  14.1M
    da6         -      -     80     60   947K  7.13M
    da2         -      -     80     66   920K  7.13M
    da10        -      -     76     62   862K  7.13M
  raidz1    13.2G  2.71T    171    917  4.32M  29.0M
    da3         -      -    110     78  1.37M  15.4M
    da11        -      -    112     55  1.41M  15.4M
    da7         -      -    115     77  1.49M  15.4M
  raidz1    5.47G  2.71T     97    485  1.93M  14.4M
    da9         -      -     64     47   665K  7.33M
    da5         -      -     65     44   631K  7.33M
    da1         -      -     64     38   677K  7.26M
  raidz1    5.50G  2.71T     92    468  1.95M  12.1M
    da0         -      -     63     50   690K  6.13M
    da8         -      -     60     46   665K  6.08M
    da4         -      -     62     57   643K  6.13M
logs            -      -      -      -      -      -
  mirror     179M  3.58G      0    196      0  14.1M
    da12p1      -      -      0    196      0  14.1M
    da13p1      -      -      0    196      0  14.1M
cache           -      -      -      -      -      -
  da12p2    4.12G   124G    160    117  3.74M  12.0M
  da13p2    4.32G   124G    205    150  4.66M  15.5M
```

_an iostat sample a few minutes into the benchmark_

```
               capacity     operations    bandwidth
pool        alloc   free   read  write   read  write
----------  -----  -----  -----  -----  -----  -----
vault       11.0G  10.9T      0    923      0   112M
  raidz1    2.09G  2.72T      0      0      0      0
    da6         -      -      0      0      0      0
    da2         -      -      0      0      0      0
    da10        -      -      0      0      0      0
  raidz1    4.04G  2.71T      0      0      0      0
    da3         -      -      0      0      0      0
    da11        -      -      0      0      0      0
    da7         -      -      0      0      0      0
  raidz1    2.47G  2.72T      0      0      0      0
    da9         -      -      0      0      0      0
    da5         -      -      0      0      0      0
    da1         -      -      0      0      0      0
  raidz1    2.46G  2.72T      0      0      0      0
    da0         -      -      0      0      0      0
    da8         -      -      0      0      0      0
    da4         -      -      0      0      0      0
logs            -      -      -      -      -      -
  mirror     322M  3.44G      0    922      0   112M
    da12p1      -      -      0    922      0   112M
    da13p1      -      -      0    923      0   112M
cache           -      -      -      -      -      -
  da12p2    1.65G   126G      0     25      0  2.88M
  da13p2    1.67G   126G      0     15      0  1.70M
```

_the zil slog devices under a 100% synchronous write workload.  those 112M are waiting in memory for the next flush event_

### l2arc

As seen in test 17, we see a moderate perfomance increase over the base case (16) when a 256GB MCL SSD is added as an l2arc device.  However, test 24 shows that if the dataset fits, there's no replacement for ram.

Test 25 shows that an l2arc was worth more than 100tps over comparable test 21 - both being under the same memory limitations.

Fitting the entire dataset into memory makes other tests less meaningful, so from here on I began putting hard limits on memory consumption.

### postgres memory vs filesystem memory

Tests 21 and 22 show that for this workload involving very small transactions, memory is more valuable dedicated to the filesystem ARC rather than to postgres itself.

### postgres configuration

In 34, 35, 36, we saw that neither effective_io_concurrency or wal_level had a postive effect.

### hdd pool vs ssd pair

Tests 32 and 39 show us that an average-sized chassis of spinning disks - with the help of an l2arc and slog - can indeed perform as fast or faster than a raid0 pair of ssds operating at default configuration in this OLTP workload.  Of course, if we apply the same tricks to the ssd pool, they of course take the lead.  Comparing tests 44 (limited memory + default settings) and 32 (limited memory + optimal settings), we see the cost of negligence is nearly an order of magnitude (145.495067tps -> 962.301782tps).
