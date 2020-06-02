## Version: 0.2
FROM centos:centos6
MAINTAINER Anton Bugreev <anton@bugreev.ru>

## Import centos 6 base key
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

## Install epel repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && \
    yum install ansible1.9 git -y

## Deploy nginx over ansible from project https://github.com/vukor/ansible-deploy-web-stack
## (we using in prod ansible; docker not yet)
RUN cd /tmp/ && \
    git clone https://github.com/vukor/ansible-deploy-web-stack && \
    cd /tmp/ansible-deploy-web-stack/ && \
    echo 'local' >> inventory/hosts && \
    ansible-playbook playbook/setup.yml -t unix,user,nginx --connection=local && \
    cd / && rm -rf /tmp/ansible-deploy-web-stack/ && \
    echo 'clean_requirements_on_remove=1' >> /etc/yum.conf && \
    yum remove ansible git epel-release -y && \
    yum clean all && \
    rm -rf /var/cache/nginx/*

## Copy nginx config to image
COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf

## Copy test
COPY tests /tests

### volumes
## nginx virtual hosts
VOLUME ["/etc/nginx/hosts/"]
## web
VOLUME ["/home/dev/logs/"]
VOLUME ["/home/dev/htdocs/"]

### main
CMD ["/usr/sbin/nginx"]

### allow ports 
EXPOSE 80
EXPOSE 443

