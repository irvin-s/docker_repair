FROM registry.access.redhat.com/rhel7:latest

RUN yum -y --disablerepo=\* --enablerepo=rhel-7-server-rpms install yum-utils &&   yum-config-manager --disable \* &&   yum-config-manager --enable rhel-7-server-rpms &&   yum-config-manager --enable rhel-7-server-extras-rpms && yum clean all && yum -y update && yum -y install http://mirror.nexcess.net/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && yum clean all && yum -y install vim docker python-docker-py openscap-scanner tar python-cherrypy uwsgi-plugin-python uwsgi-router-http uwsgi-plugin-common python-psutil findutils python-flask git make rpm-build python-setuptools && yum clean all

LABEL Version=1.0
LABEL Vendor="Red Hat" License=GPLv3

LABEL INSTALL="docker run --rm -it --privileged -v /etc/:/host/etc/ -e IMAGE=IMAGE -e NAME=NAME IMAGE sh /root/image-scanner/docker/image-scanner-install.sh"

LABEL RUN="docker run -dt --privileged -v /proc/:/hostproc/ -v /sys/fs/cgroup:/sys/fs/cgroup  -v /var/log:/var/log -v /var/tmp/image-scanner:/var/tmp/image-scanner -v /run:/run -v /var/lib/docker/devicemapper/metadata/:/var/lib/docker/devicemapper/metadata/ -v /dev/:/dev/ -v /etc/image-scanner/:/etc/image-scanner --env container=docker --net=host --cap-add=SYS_ADMIN --ipc=host IMAGE"

RUN echo 'PS1="[image-scanner]#  "' > /etc/profile.d/ps1.sh

COPY ./ /root/image-scanner/

RUN cd /root/image-scanner && make clean && make -C packaging -f Makefile.dist-packaging rpm && yum -y localinstall /root/image-scanner/packaging/noarch/image-scanner-*.noarch.rpm && yum clean all

CMD /usr/bin/image-scanner-d
