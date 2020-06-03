FROM corebuild
MAINTAINER docker@softwarecollections.org  
#RUN yum-config-manager --disable "*" --enable rhel-server-rhscl-7-rpms --enable rhel-7-server-optional-rpms
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms --enable rhel-7-server-optional-rpms && \
    yum install -y --nogpgcheck --setopt=tsflags=nodocs rh-mysql57 && \
    yum clean all && \
    rm -rf /var/cache/yum/*
RUN systemctl enable rh-mysql57-mysqld
EXPOSE 3306
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
