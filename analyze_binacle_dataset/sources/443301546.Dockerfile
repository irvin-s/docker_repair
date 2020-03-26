FROM ubuntu:trusty

# install couchdb and curl
RUN apt-get -y update
RUN apt-get -y -q install couchdb curl git
RUN apt-get -y -q clean

# install nodejs
RUN curl -o ~/node.tar.gz http://nodejs.org/dist/v0.10.28/node-v0.10.28-linux-x64.tar.gz
RUN cd /usr/local && tar --strip-components 1 -xzf ~/node.tar.gz
RUN rm ~/node.tar.gz

# install hoodie-cli
RUN npm install -g hoodie-cli

# add hoodie user
RUN useradd --create-home --user-group --shell /bin/bash hoodie

# create hoodie project
RUN cd /home/hoodie && sudo -u hoodie HOME=/home/hoodie hoodie new project

ENV HOODIE_SETUP_PASSWORD changeme

RUN echo "cd /home/hoodie/project && HOME=/home/hoodie npm start" \
    > /home/hoodie/start.sh

USER hoodie
CMD ["bash", "/home/hoodie/start.sh"]

EXPOSE 6001
EXPOSE 6002
