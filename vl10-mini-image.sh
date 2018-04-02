#!/bin/bash

export rootfs=/root/dev/vl10-mini-rootfs
export vl10repo=/root/dev/vl10-repo
rpm --root ${rootfs} --initdb
rpm --root ${rootfs} -ivh \
    ${vl10repo}/vanlos-release/vanlos-release-10-2.1804.vl10.x86_64.rpm \
    ${vl10repo}/bash/bash-4.2.46-29.vl10.x86_64.rpm \
    ${vl10repo}/gcc/libgcc-4.8.5-16.vl10.2.x86_64.rpm \
    ${vl10repo}/gcc/libstdc++-4.8.5-16.vl10.2.x86_64.rpm \
    ${vl10repo}/glibc/glibc-2.17-196.vl10.2.x86_64.rpm \
    ${vl10repo}/glibc/glibc-common-2.17-196.vl10.2.x86_64.rpm \
    ${vl10repo}/basesystem/basesystem-10.0-7.vl10.noarch.rpm \
    ${vl10repo}/libselinux/libselinux-2.5-11.vl10.x86_64.rpm \
    ${vl10repo}/libsepol/libsepol-2.5-6.vl10.x86_64.rpm \
    ${vl10repo}/ncurses/ncurses-5.9-14.20130511.vl10.x86_64.rpm \
    ${vl10repo}/ncurses/ncurses-base-5.9-14.20130511.vl10.noarch.rpm \
    ${vl10repo}/ncurses/ncurses-libs-5.9-14.20130511.vl10.x86_64.rpm \
    ${vl10repo}/nss-softokn/nss-softokn-freebl-3.28.3-8.vl10.x86_64.rpm \
    ${vl10repo}/nspr/nspr-4.13.1-1.0.vl10.x86_64.rpm \
    ${vl10repo}/filesystem/filesystem-3.2-21.vl10.x86_64.rpm \
    ${vl10repo}/pcre/pcre-8.32-17.vl10.x86_64.rpm \
    ${vl10repo}/setup/setup-2.8.71-7.vl10.noarch.rpm \
    ${vl10repo}/tzdata/tzdata-2018c-1.vl10.noarch.rpm \
    ${vl10repo}/xz/xz-5.2.2-1.vl10.x86_64.rpm \
    ${vl10repo}/xz/xz-libs-5.2.2-1.vl10.x86_64.rpm 
if [ $? != 0 ]; then
    echo "Install rpms failed!!!"
    exit 1
fi
    
cat << EOF >  ${rootfs}/etc/yum.repos.d/vl10.repo
[vl10]
name=vl10
baseurl=ftp://118.24.125.128/pub/vl10/
enabled=1
gpgcheck=0
EOF

cd ${rootfs}
yum -y --installroot=${rootfs} install yum bash-completion
yum --installroot=${rootfs} check
yum --installroot=${rootfs} clean all
#chroot ${rootfs} /bin/bash
rm -rf ${rootfs}/etc/yum.repos.d/vl10.repo
tar -C ${rootfs}/ -c . | docker import - vl10
docker save vl10:latest | xz - > vl10.2.1804.tar.xz
