FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y git git-core wget zip nodejs npm

#################################
# Symlinking Nodejs for ubuntu
#   -- http://stackoverflow.com/questions/26320901/cannot-install-nodejs-usr-bin-env-node-no-such-file-or-directory
#################################
RUN ln -s /usr/bin/nodejs /usr/bin/node

#################################
# NPM install globals
#################################
RUN npm install bower -g

EXPOSE 80

# startup
ADD start.sh /tmp/
RUN chmod +x /tmp/start.sh
CMD ./tmp/start.sh