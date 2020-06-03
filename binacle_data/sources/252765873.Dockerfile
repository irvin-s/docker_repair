# This image is basically just ubuntu with sshd installed and configured  
FROM 42nerds/jenkins-node:latest  
MAINTAINER 42nerds - Inh. Julian Kaffke <info@42nerds.com>  
  
#Install bower and gulp globally  
RUN npm install -g bower gulp  
  
CMD ["/usr/sbin/sshd", "-D"]

