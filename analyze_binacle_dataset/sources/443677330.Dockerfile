from centos
RUN yum -y update && yum install -y createrepo
CMD createrepo
