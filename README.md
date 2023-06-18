
```
$ mkdir /tmp/docker
$ docker image build -t clutch ./ 
$ docker run --rm -v /tmp/docker/:/tmp/mnt_host -it clutch /bin/bash
```
