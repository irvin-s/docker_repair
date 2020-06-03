# Set the base image to Ubuntu  
FROM sylvainlasnier/ubuntu  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
# Install Node.js and other dependencies  
RUN apt-get update && \  
apt-get -y install curl && \  
curl -sL https://deb.nodesource.com/setup | sudo bash - && \  
apt-get -y install python build-essential nodejs git  
  
# Install nodemon  
RUN npm install -g nodemon  
  
# Define working directory  
WORKDIR /src  
  
# clone tilehut GIT repo  
RUN git clone https://github.com/b-g/tilehut .  
RUN npm install  
  
# Expose port  
EXPOSE 8000  
# Run app using nodemon  
CMD /usr/bin/nodemon /src/server.js

