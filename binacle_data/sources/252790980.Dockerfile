FROM centos:6  
  
ENV http_proxy=$http_proxy  
ENV https_proxy=$https_proxy  
ENV ftp_proxy=$ftp_proxy  
  
RUN printf $'[mariadb]\n\  
name=MariaDB\n\  
baseurl=https://yum.mariadb.org/10.0/centos6-amd64\n\  
gpgcheck=0\n' > /etc/yum.repos.d/mariadb.repo  
RUN yum install -y initscripts cmake gcc-c++ boost-devel MariaDB-devel\  
zlib-devel openssl-devel MariaDB-server make &&\  
yum clean all &&\  
rm -rf /tmp/* /var/tmp/* /var/cache/yum /var/lib/mysql/*  

