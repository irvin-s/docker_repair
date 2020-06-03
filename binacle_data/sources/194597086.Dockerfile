## Version: 0.2
FROM centos:centos6
MAINTAINER Anton Bugreev <anton@bugreev.ru>

## Import centos 6 base key
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

## Install epel repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && \
    yum install ansible1.9 git -y

## Deploy mysql role with ansible, we using ansible in prod - not yet docker
RUN cd /tmp/ && \
    git clone https://github.com/vukor/ansible-deploy-web-stack && \
    cd /tmp/ansible-deploy-web-stack/ && \
    echo 'local' >> inventory/hosts && \
    ansible-playbook playbook/setup.yml -t unix,remi,mysql --connection=local && \
    cd / && rm -rf /tmp/ansible-deploy-web-stack/ && \
    echo 'clean_requirements_on_remove=1' >> /etc/yum.conf && \
    yum remove ansible git epel-release -y && \
    yum clean all

### Volumes
VOLUME ["/var/log/mysql/"]

## Copy mysql backup/restore scripts
COPY ./opt /opt

## Copy tests
COPY tests /tests

### Main
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/libexec/mysqld"]

### Allow ports
EXPOSE 3306
