FROM 08101996/custom_node_chord:0.4.0  
#LABEL version="9.1.3"  
RUN mkdir -p /usr/src/  
WORKDIR /usr/src/  
COPY . /usr/src/  
  
RUN npm install --production --remove-dev  
ENV SOCKETCLUSTER_WORKERS=2  
CMD ["npm", "run", "start:docker"]

