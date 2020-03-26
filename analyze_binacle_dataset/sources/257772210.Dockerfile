FROM registry.access.redhat.com/rhel7
RUN /usr/bin/yum-config-manager --disable rhel-7-server-htb-rpms
RUN /usr/bin/yum -y install elfutils gdb bzip2 unzip
RUN /usr/bin/yum-config-manager --enable \*-debug-rpms
RUN /usr/bin/yum-config-manager --setopt=\*.skip_if_unavailable=true  --save


