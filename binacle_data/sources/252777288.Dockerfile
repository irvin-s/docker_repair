FROM centos:latest  
MAINTAINER cevich@redhat.com  
ENV container="docker" \  
img_name="travis_centos"  
ADD ["/${img_name}.dockerfile", "/${img_name}.packages", "/root/"]  
ADD ["install.sh", "/root/bin/"]  
RUN /root/bin/install.sh  

