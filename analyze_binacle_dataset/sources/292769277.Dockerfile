FROM centos:7

ARG ansible_version
ENV ansible_version=$ansible_version
ARG foreman_version
ENV foreman_version=$foreman_version
ARG katello_version
ENV katello_version=$katello_version

# Install systemd -- See https://hub.docker.com/_/centos/
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y install epel-release https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm https://yum.theforeman.org/releases/$foreman_version/el7/x86_64/foreman-release.rpm
RUN if [ "$katello_version" != "" ]; then yum -y install https://fedorapeople.org/groups/katello/releases/yum/$katello_version/katello/el7/x86_64/katello-repos-latest.rpm ; fi
RUN yum -y install git python-pip sudo
RUN if [ "$ansible_version" = "latest" ]; then pip install ansible; else pip install ansible==$ansible_version; fi 
RUN pip install ansible-lint urllib3 pyOpenSSL ndg-httpsclient pyasn1

RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]
EXPOSE 443
