
```
$ mkdir /tmp/docker
$ docker image build -t clutch ./ 
$ docker run  -v /tmp/docker/:/tmp/mnt_host -it clutch /bin/bash
```
