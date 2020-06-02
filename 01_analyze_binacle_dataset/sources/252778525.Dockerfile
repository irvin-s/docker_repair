FROM node:4.4.7  
RUN apt-get update && apt-get install -yy sudo  
  
RUN npm install -g gulp  
  
# Define default command.  
WORKDIR /data  
CMD ["bash"]  

