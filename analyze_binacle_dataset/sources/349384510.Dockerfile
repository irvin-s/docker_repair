FROM fedora
MAINTAINER Peter Ruan (pruan@redhat.com)
ENV DEFAULT_LOCAL_TMP /tmp
ENV ANSIBLE_LOCAL_TEMP /tmp
USER root
RUN yum -y install ed iproute python-dbus PyYAML yum-utils pyOpenSSL python-cryptography python-lxml java-1.8.0-openjdk java-1.8.0-openjdk-devel httpd-tools libselinux-python python-httplib2 python-jinja2 python-keyczar python-paramiko python-passlib python-setuptools sshpass rsync
RUN chmod 770 /etc
RUN adduser --system -s /bin/bash -u 1234321 -g 0 ansible
RUN chmod 664 /etc/passwd /etc/group
# set ansible to ignore ssh-key check
ENV ANSIBLE_HOST_KEY_CHECKING=False
# enable anisble color output
ENV ANSIBLE_FORCE_COLOR=True
ENV ANSIBLE_CALLBACK_WHITELIST=profile_tasks
# set plugins search path
ENV ANSIBLE_FILTER_PLUGINS=/usr/share/ansible_plugins
ENV ANSIBLE_CALLBACK_PLUGINS=/usr/share/ansible_plugins
ENV ANSIBLE_LOOKUP_PLUGINS=/usr/share/ansible_plugins
CMD sleep infinity
