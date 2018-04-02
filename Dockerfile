FROM vl10:20180320

ENV container docker
MAINTAINER VanlOS Tech. <vanloswang@126.com>

RUN yum -y update; yum clean all

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y install openssh-server passwd vim gcc gcc-c++ git wget make createrepo python-libcomps; yum clean all; systemctl enable sshd
RUN mkdir /var/run/sshd && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && echo '123456'| passwd --stdin root

ADD macros.dist /etc/rpm/
ADD rpmmacros /root/.rpmmacros
ADD vimrc /root/.vimrc

VOLUME [ "/sys/fs/cgroup" ]
VOLUME [ "/mnt" ]

CMD ["/usr/sbin/init"]
