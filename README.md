# QPKG unifi

QNAP Dockerized unifi

## Build it

```
$ docker run -it --rm -v ${PWD}:/src dorowu/qdk2-build                                                                                                                                              20 ↵
Creating archive with data files...
tar:   30kB 0:00:00 [12.8MB/s] [====================================================================================================================================================] 114%
Creating archive with control files...
Creating QPKG package...
-rw-r--r-- 1 1000 1000 27094 Mar  1 23:19 unifi_5.4.11.qpkg
```

You will find `*.qpkg` in the current folder or [download here](http://qnap-ubuntu.dorowu.com/qpkg/unifi_5.4.11.qpkg)
