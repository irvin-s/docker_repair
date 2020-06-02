#Docker file for node  
#run this so that file changes get built on server  
FROM amlwwalker/docker-node-python-dev:latest  
  
RUN npm install -g nodemon  
WORKDIR /srv/app  
ADD . /srv/app  
  
EXPOSE 3000  
ENTRYPOINT ["nodemon", "./bin/www"]

