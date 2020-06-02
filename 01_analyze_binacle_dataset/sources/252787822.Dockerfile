FROM node:7.6.0  
# Where the app lives inside of the container file system  
ENV APPHOME=/app  
COPY src $APPHOME  
  
# Set user and install npm packages  
WORKDIR $APPHOME  
RUN npm install  
  
ENV TZ=Europe/Prague  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
  
# Run the node.js app  
CMD ["node", "main.js"]

