FROM centos:latest
MAINTAINER michelkaeser

# initial upgrade (+ dependencies installation)
RUN yum upgrade -y && yum install -y epel-release openssl

# add Pritunl repository
COPY pritunl.repo /etc/yum.repos.d/pritunl.repo
RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys CF8E292A
RUN gpg --armor --export CF8E292A > key.tmp; rpm --import key.tmp; rm -f key.tmp

# install Pritunl + MongoDB server
RUN yum install -y pritunl mongodb-server

# use predefined Pritunl config for local MongoDB server
COPY pritunl.conf /etc/pritunl.conf

# support files
COPY pritunl.sh /usr/local/bin/pritunl.sh
RUN chmod +x /usr/local/bin/pritunl.sh

# cleanup
RUN yum clean all
RUN rm -rf /var/tmp/* /tmp/*

# meta
CMD /usr/local/bin/pritunl.sh
EXPOSE 1194/udp 1194/tcp 443/tcp
VOLUME /var/lib/mongodb /var/lib/pritunl
