FROM node:slim  
  
# change the npm loglevel to warn  
ENV NPM_CONFIG_LOGLEVEL warn  
  
EXPOSE 3000  
RUN mkdir -p /frontend  
WORKDIR /frontend  
  
# copy dependency files and install dependencies  
COPY package.json package.json  
COPY npm-shrinkwrap.json npm-shrinkwrap.json  
RUN npm install  
  
# copy all the other files into the container  
COPY . /frontend  
  
RUN chmod +x _tooling/run_server.sh  
  
CMD ["/frontend/_tooling/run_server.sh"]  

