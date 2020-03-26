# Basic Environment for Node.js ver 6.x  
FROM node:6-alpine  
  
# Update package list  
RUN apk update  
  
# Install required packages  
RUN apk add sudo bash expect curl  
  
# Create user for development  
RUN adduser -s /bin/bash -D nodeuser  
RUN echo "nodeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  
RUN echo 'nodeuser:nodeuser' | chpasswd  
RUN echo 'root:root' | chpasswd  
  
# Install develop environments for local user  
# Please replace the following placeholder 'xxxxx' to your required packages  
# RUN npm install -g xxxxx  
RUN sudo npm install -g vue-cli  
  
# Change user as local user  
USER nodeuser  
WORKDIR /home/nodeuser  
  
# Launch as background  
CMD ["/bin/bash", "-c", "tail -f /dev/null"]  

