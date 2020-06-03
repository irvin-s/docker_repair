FROM centos:centos6  
RUN curl --silent --location https://rpm.nodesource.com/setup | bash -  
RUN yum install -y nodejs  
# Bundle app source  
COPY . /src  
# Install app dependencies  
RUN cd /src; npm install  
EXPOSE 8080  
CMD ["node", "/src/bin/www"]

