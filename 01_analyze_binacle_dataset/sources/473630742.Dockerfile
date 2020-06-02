FROM centos:centos7
RUN yum -y clean all
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install openssh-clients
RUN yum -y install nginx

EXPOSE 8080
EXPOSE 8081

ADD nginx.conf /etc/nginx/nginx.conf
ADD run.sh run.sh
ADD htpasswd /etc/nginx/.htpasswd

CMD bash run.sh


