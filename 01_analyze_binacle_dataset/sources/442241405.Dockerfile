# Dockerizing MongoDB: Dockerfile for building MongoDB images
# Based on ubuntu:latest, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Format: FROM    repository[:version]
FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Jonas Colmsjö <jonas@gizur.com>

RUN apt-get update
RUN apt-get install -y curl

RUN echo "export HOME=/" > /.profile

#
# Install supervidord (used to handle processes)
#

RUN apt-get install -y supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf


#
# Install MongoDB
#


# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

# Update apt-get sources AND install MongoDB
RUN apt-get update
RUN apt-get install -y -q mongodb-org

# It is possible to install a specific version also
# RUN apt-get install -y -q mongodb-org=2.6.1 mongodb-org-server=2.6.1 mongodb-org-shell=2.6.1 mongodb-org-mongos=2.6.1 mongodb-org-tools=2.6.1

# Create the MongoDB data directory
RUN mkdir -p /data/db

ADD ./etc-mongod.conf /etc/mongod.conf


#
# Install NodeJS
#

ADD ./init-node.sh /src/

# Download and install using npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.11.1/install.sh | bash
RUN echo "[ -s /.nvm/nvm.sh ] && . /.nvm/nvm.sh" >> /.profile
RUN /bin/bash -c "source /.profile && nvm install v0.11.2"

# Install node for root user together node jaydata etc.
RUN /src/init-node.sh
 
# Fix a broken package.json (connect need to be exactly 2.0.0)
ADD ./odata-server-package.json /.nvm/v0.11.2/lib/node_modules/odata-server/package.json
RUN /bin/bash -c "source $HOME/.nvm/nvm.sh; nvm use v0.11.2; cd /.nvm/v0.11.2/lib/node_modules/odata-server; npm install ."


#
# Start things up
#


EXPOSE  27017 52999 80 443 8080
CMD ["supervisord","-n"]
