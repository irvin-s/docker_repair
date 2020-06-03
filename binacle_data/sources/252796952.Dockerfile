FROM node:alpine  
  
# Environment variables (updated by build hook)  
ENV INSTALL_DIR /usr/src/app  
# {{ENV}}  
# Create app directory & copy package.json  
RUN mkdir -p $INSTALL_DIR/source  
COPY source/package.json $INSTALL_DIR/source  
WORKDIR $INSTALL_DIR/source  
  
# Install dependencies using package.json  
RUN npm install  
  
# Copy config  
RUN mkdir -p $INSTALL_DIR/config  
COPY config $INSTALL_DIR/config  
  
# Copy everything else  
COPY source $INSTALL_DIR/source  
  
# Expose port  
EXPOSE 8080  
  
# Start server  
CMD [ "npm", "start" ]  

