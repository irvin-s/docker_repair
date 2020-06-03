FROM node:6-slim  
  
RUN apt-get update && apt-get install -y git \  
\--no-install-recommends \  
&& rm -rf /var/lib/apt/lists/*  
  
ARG VERSION=0.6.0  
  
RUN npm install matrix-appservice-irc@$VERSION --global  
  
# workaround for not found lib/config/schema.yaml  
WORKDIR /usr/local/lib/node_modules/matrix-appservice-irc  
  
ENTRYPOINT [ "matrix-appservice-irc" ]  
  

