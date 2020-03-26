FROM node:6-alpine  
# Set environment variables  
ENV APP_DIR /var/tlm-suppliers  
  
# Set the work directory  
RUN mkdir -p /var/tlm-suppliers  
WORKDIR ${APP_DIR}  
# Add our package.json and install *before* adding our application files  
ADD package.json ./  
RUN yarn install  
  
ADD . /var/tlm-suppliers  
  
RUN rm -rf config  
RUN mv config_examples config  
RUN yarn deploy:prod  
  
#Expose the port  
EXPOSE 3048  
CMD ["npm", "start"]  

