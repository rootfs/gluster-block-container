#!/bin/bash

mkdir -p /home/disks

umount /tmp/gluster_disk0
dd if=/dev/zero of=/home/disks/d0 bs=1024M count=1 conv=notrunc
mkfs -t xfs -f /home/disks/d0
mkdir -p /tmp/gluster_disk0
mount -t xfs -o loop  /home/disks/d0 /tmp/gluster_disk0

docker build -t gluster-block .
docker run -ti --privileged -v /tmp/gluster_disk0:/vol -v /lib/modules:/lib/modules gluster-block
