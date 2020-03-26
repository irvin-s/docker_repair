#  
# Ghost Dockerfile  
#  
# https://github.com/almat64/docker-ghost  
# forked from  
# https://github.com/dockerfile/ghost  
#  
# Pull base image.  
FROM dockerfile/nodejs  
  
# Import deploy key  
RUN mkdir -p /root/.ssh  
ADD id_rsa /root/.ssh/id_rsa  
RUN chmod 700 /root/.ssh/id_rsa  
ADD config /root/.ssh/config  
  
# Install Ghost  
RUN \  
cd /tmp && \  
git clone git@github.com:almat64/Ghost.git /ghost && \  
cd /ghost && \  
git checkout stable && \  
npm install && \  
sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js && \  
touch /ghost/.npmignore && \  
npm install -g grunt && \  
export PATH=$PATH:/ghost/node_modules/.bin/ && \  
grunt init && \  
grunt prod && \  
rm -rf /ghost/.git && \  
useradd ghost --home /ghost  
  
# Add files.  
ADD start.bash /ghost-start  
  
# Set environment variables.  
ENV NODE_ENV production  
  
# Define mountable directories.  
VOLUME ["/data", "/ghost-override"]  
  
# Define working directory.  
WORKDIR /ghost  
  
# Define default command.  
CMD ["bash", "/ghost-start"]  
  
# Expose ports.  
EXPOSE 2368  

