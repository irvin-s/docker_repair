# The official nodejs docker image  
FROM node:latest  
  
# Download typings  
RUN npm install -g typings tsd  
  
#Copy package.json only to temp folder, install its dependencies,  
# set workdir and copy the dependnecies there  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p /home/app && cp -a /tmp/node_modules /home/app/  
WORKDIR /home/app  
  
ADD typings.json /tmp/typings.json  
RUN cd /tmp && typings install  
RUN mkdir -p /home/app && cp -a /tmp/typings /home/app/  
  
# install webpack & forever to build the application  
RUN npm install -g webpack forever  
  
# Copy the rest of the files to the container workdir  
ADD . /home/app  
  
ENV SOCKETIO_URL=http://oasis-server.oasis.ohadgk.svc.tutum.io:8080  
ENV API_URL=http://oasis-server.oasis.ohadgk.svc.tutum.io:8080  
ENV NODE_ENV=production  
# build the application  
RUN webpack  
  
EXPOSE 8080  
# The command run our app as forever process as PID 1 (main).  
#CMD ["forever", "server/app.js"]  
CMD ["node", "server/app.js"]

