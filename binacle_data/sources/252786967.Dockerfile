FROM node:5.6.0  
MAINTAINER bradojevic@gmail.com  
  
# Install Bower & Grunt. We need yeoman user for yo to work  
# it has some issues with root user  
RUN npm install -g bower grunt-cli && \  
echo '{ "allow_root": true }' > /root/.bowerrc  
  
RUN npm install -g yo generator-cg-angular generator-static-website-docker  
RUN adduser --disabled-password --gecos "" yeoman;  
RUN echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  
  
ENV HOME /home/yeoman  
  
USER yeoman  
  
# Define working directory.  
RUN mkdir -p /home/yeoman/src  
RUN echo 'Welcome to angular-sendbox!' > /home/yeoman/welcome  
WORKDIR /home/yeoman/src  
VOLUME ['/home/yeoman/src']  
  
EXPOSE 9000 9001 35729 8000 8080 8081 8082 8083  
CMD ["tail", "-f", "/home/yeoman/welcome"]  

