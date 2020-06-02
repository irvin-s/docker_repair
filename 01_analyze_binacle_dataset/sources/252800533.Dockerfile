FROM centos:centos6  
MAINTAINER donald gifford <dgifford06@gmail.com>  
ENV REFRESHED_AT 2014-12-31  
RUN yum update -y  
RUN curl -sL https://rpm.nodesource.com/setup | bash -  
RUN yum install nodejs -y  
  
COPY ./src /src  
RUN cd /src; npm install  
EXPOSE 8080  
CMD ["node", "/src/index.js"]

