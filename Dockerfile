FROM fedora:25

MAINTAINER hchen@redhat.com

ENV container docker

RUN yum -y update
RUN yum --setopt=tsflags=nodocs -y install procps attr glusterfs glusterfs-server glusterfs-geo-replication openssh-server tcmu-runner hostname dnf-plugins-core; yum clean all
RUN dnf config-manager --add-repo https://download.gluster.org/pub/gluster/gluster-block/gluster-block.repo
RUN dnf install -y gluster-block

EXPOSE 22 111 245 443 24007 24006 2049 8080 6010 6011 6012 38465 38466 38468 38469 49152 49153 49154 49156 49157 49158 49159 49160 49161 49162 49163

ADD glusterd.vol /etc/glusterfs/
ADD run_gluster.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/run_gluster.sh"]