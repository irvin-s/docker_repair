FROM xeor/base-centos

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-12-15

# Installing supervisord the "os-way" (to get default configs and so on), and then upgrading it to the pip version..
RUN yum install -y python-pip supervisor && yum clean all && \
    pip install --upgrade supervisor

COPY init/ /init/
