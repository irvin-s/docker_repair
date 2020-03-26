FROM node:7  
# Home directory for Node-RED application source code.  
RUN mkdir -p /usr/src/node-red  
# User data directory, contains flows, config and nodes.  
RUN mkdir -p /data/node_modules  
  
WORKDIR /usr/src/node-red  
# Copying folder content to container storage  
COPY . /usr/src/node-red/  
RUN cd /usr/src/node-red/nodes/core; \  
find -name '*.html' | \  
grep -v -e 'template' | \  
awk '{system("mv "$1" "$1".ign")}';  
  
# Add node-red user so we aren't running as root.  
# And add all dojot-related nodes  
COPY contrib-nodes /data/node_modules  
RUN useradd --home-dir /usr/src/node-red \--no-create-home node-red \  
&& rm -fr /usr/src/node-red/node_modules \  
&& chown -R node-red:node-red /data \  
&& chown -R node-red:node-red /usr/src/node-red  
USER node-red  
RUN npm install && npm run build && cd /data && npm install  
  
# Default Node-RED port  
EXPOSE 1880 3000  
# Environment variable holding file path for flows configuration  
ENV FLOWS=flows.json  
  
CMD ["npm", "start", "--", "--userDir", "/data"]  

