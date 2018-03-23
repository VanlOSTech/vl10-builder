# Building & Running

Copy the sources to your docker host and build the container:

	# docker build --rm -t vl10/vl10-builder:latest .

To run:

    # chcon -Rt svirt_sandbox_file_t /root/dev
    # docker run --privileged --name vl10-builder -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /root/dev/:/mnt/ -p 50022:22 -d vl10/vl10-builder:latest

Get the port that the container is listening on:

```
# docker ps
CONTAINER ID        IMAGE                 	   COMMAND             CREATED             STATUS              PORTS                   NAMES
8c82a9287b23        vl10/vl10-builder:latest   /usr/sbin/sshd -D   4 seconds ago       Up 2 seconds        0.0.0.0:50022->22/tcp   vl10-builder
```

To test, use the port that was just located:

	# ssh -p 50022 root@localhost 

