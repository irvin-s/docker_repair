# MySQL Server with Apache and phpmyadmin
#
# VERSION               0.0.1

FROM     base
MAINTAINER Jonas Colmsjö "jonas@gizur.com"


RUN apt-get update
RUN apt-get install -y curl git

# Install NodeJS

RUN curl https://raw.github.com/creationix/nvm/master/install.sh | sh
RUN echo "[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh" > /.profile
RUN /bin/bash -c "source /.profile && nvm install v0.11.2"

ADD . /src

RUN /src/init-node.sh

# Just a exmaple, change
RUN npm install ftp-server


EXPOSE 20 21
CMD ["node","/src/ftp-server.js"]
