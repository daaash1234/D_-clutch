
```
$ mkdir /tmp/docker
$ docker image build -t clutch ./ 
$ docker run -p 63389:3389 -v /tmp/docker/:/tmp/mnt_host -it clutch /bin/bash
```
