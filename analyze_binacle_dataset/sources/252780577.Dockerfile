FROM node:5.3  
# INSTALL enclose  
RUN npm install -g enclose  
  
WORKDIR /code  
  
ENTRYPOINT [ "enclose" ]

