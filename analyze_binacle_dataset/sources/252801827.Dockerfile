FROM centos:latest  
RUN yum update -y && yum clean all && yum install epel-release -y && \  
yum install nodejs npm unzip -y && \  
cd /tmp/ && curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip && \  
mkdir -p /app && \  
unzip -uo /tmp/ghost.zip -d /app && \  
rm -rf /tmp/ghost.zip && \  
cd /app && npm install --production --prefix /app  
ADD config.js /app/  
ENV URL='http://localhost:2368'  
VOLUME ["/app/content"]  
WORKDIR /app  
EXPOSE 2368  
CMD ["node", "index.js"]  
  

