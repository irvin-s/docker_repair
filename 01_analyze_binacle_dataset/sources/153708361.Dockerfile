# Node JS dockerfile

FROM gezpage/ubuntu

MAINTAINER gezpage@gmail.com

RUN apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get --yes install \
    git-core curl python-software-properties vim; \
  add-apt-repository -y ppa:chris-lea/node.js; \
  apt-get update; \
  apt-get install -y nodejs; \
  npm install --global express jade socket.io less

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]
