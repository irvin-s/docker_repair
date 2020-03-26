FROM anothersoftwaredevelopmentblog/docker-node-centos:centos7  
  
RUN n 7.10.0  
RUN npm install -g @angular/cli  
RUN yum install -y chromium xorg-x11-server-Xvfb  
  
ADD *.sh /  
RUN chmod +x /*.sh  
  
RUN git clone https://github.com/kr-g/angular-bootstrap-quickstart.git /repo  
  
WORKDIR /repo  
  
RUN npm install  
  
# important !!!  
# create volume after npm install  
# due to bug in aufs npm will not create node_module otherwise  
VOLUME /repo  
  
EXPOSE 3000  
CMD [ "/startup.sh" ]  
  

