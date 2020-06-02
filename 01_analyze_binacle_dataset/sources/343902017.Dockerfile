FROM fedora:latest

RUN dnf -y install vim docker python-docker-py openscap-scanner tar python-cherrypy uwsgi-plugin-python uwsgi-router-http uwsgi-plugin-common python-psutil findutils python-flask git make rpm-build && dnf clean all


LABEL Version=1.0
LABEL Vendor="Red Hat" License=GPLv3

LABEL INSTALL="docker run --rm -it --privileged -v /etc/:/host/etc/ -e IMAGE=IMAGE -e NAME=NAME IMAGE sh /root/image-scanner/docker/image-scanner-install.sh"

LABEL RUN="docker run -dt --privileged -v /proc/:/hostproc/ -v /sys/fs/cgroup:/sys/fs/cgroup  -v /var/log:/var/log -v /tmp:/tmp -v /run:/run -v /var/lib/docker/devicemapper/metadata/:/var/lib/docker/devicemapper/metadata/ -v /dev/:/dev/ -v /etc/image-scanner/:/etc/image-scanner --env container=docker --net=host --cap-add=SYS_ADMIN --ipc=host IMAGE"

RUN echo 'PS1="[image-scanner]#  "' > /etc/profile.d/ps1.sh

COPY ./ /root/image-scanner/

RUN cd /root/image-scanner && make clean && make -C packaging -f Makefile.dist-packaging rpm && dnf -y install /root/image-scanner/packaging/noarch/image-scanner-*.noarch.rpm && dnf clean all

CMD /usr/bin/image-scanner-d
