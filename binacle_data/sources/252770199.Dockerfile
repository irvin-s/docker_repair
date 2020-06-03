FROM node:9-stretch  
  
# set node environmet to production  
ARG NODE_ENV=production  
ENV NODE_ENV $NODE_ENV  
  
# default port 3000 for express  
ARG PORT=3000  
ENV PORT $PORT  
EXPOSE $PORT  
  
# check every 30 s to ensure this service returns HTTP 200  
HEALTHCHECK CMD curl -fs http://localhost:$PORT || exit 1  
  
WORKDIR /usr/src/app  
  
# link stderr and stdout to logs  
RUN ln -sf /dev/stdout /var/log/node_stdout.log && \  
ln -sf /dev/stderr /var/log/node_stderr.log  
  
# Run npm installl  
ENTRYPOINT npm install && npm cache clean --force && npm start  
#CMD ["node", "./bin/www"]  

