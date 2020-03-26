#Parent image for dockerfile
FROM ubuntu

#Installing app dependencies and relevant packages for the project
RUN apt-get update -y --fix-missing && \
    apt-get -y install nodejs && \
    apt-get -y install npm && \
    apt-get -y install mongodb-server && \
    mkdir /srv/www

#Copying source code content to docker container 
COPY .  /srv/www/ExpressJS-API-Demo

#Copying start script for Node.js application
COPY start.sh  /srv/www/start.sh

#Making start script executable
RUN chmod +x /srv/www/start.sh

#Running start script after launching docker container
ENTRYPOINT "/srv/www/start.sh" && /bin/bash
