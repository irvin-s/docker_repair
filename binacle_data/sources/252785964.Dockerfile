FROM node:0.12  
RUN npm install -g gulp mocha  
  
EXPOSE 3000  
CMD ["/bin/bash"]

