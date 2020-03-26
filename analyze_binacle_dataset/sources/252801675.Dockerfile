FROM centos:latest  
MAINTAINER Edward Cheadle <edward.cheadle@cambiahealth.com  
RUN yum update -y  
RUN yum install -y bind-license bind bind-utils  

