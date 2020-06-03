FROM mhart/alpine-node:4  
# ---- ADD CUSTOM NODES ----  
#RUN npm install \  
# node-red-contrib-alexa-home-skill \  
# node-red-contrib-light-scheduler \  
# node-red-contrib-stoptimer \  
# node-red-contrib-os \  
# node-red-node-mysql  
# --------------------------------  
# Home directory for Node-RED application source code.  
RUN mkdir -p /usr/src/node-red  
# User data directory, contains flows, config and nodes.  
RUN mkdir /data  
  
WORKDIR /usr/src/node-red  
# Add node-red user so we aren't running as root.  
RUN adduser -h /usr/src/node-red -D -H node-red \  
&& chown -R node-red:node-red /data \  
&& chown -R node-red:node-red /usr/src/node-red  
USER node-red  
# package.json contains Node-RED NPM module and node dependencies  
COPY package.json /usr/src/node-red/  
RUN npm install  
  
# User configuration directory volume  
VOLUME ["/data"]  
EXPOSE 1880  
# Environment variable holding file path for flows configuration  
ENV FLOWS=flows.json  
  
CMD ["npm", "start", "--", "--userDir", "/data"]  

