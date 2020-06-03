FROM node:6  
LABEL maintainer="leoliang@gmail.com"  
LABEL description="Node.js project development environment"  
  
# Install additional Linux tools  
RUN apt-get update \  
&& apt-get install -y vim less net-tools jq  
  
# Make node-gyp cache  
# Install global modules  
RUN cd /tmp \  
&& yarn add heapdump \  
&& rm -rf /tmp/* \  
&& yarn global add npm-check-updates  
  
VOLUME ["/project", "/project/node_modules"]  
  
WORKDIR /project  
  
CMD ["/bin/bash", "-c", "yarn install; /bin/bash"]  

