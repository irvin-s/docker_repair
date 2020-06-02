FROM debian:jessie
MAINTAINER Peter Hedenskog <peter@soulgalore.com>

RUN apt-get update \
 && apt-get install -y --force-yes --no-install-recommends\
      apt-transport-https \
      build-essential \
      curl \
      ca-certificates \
      git \
      lsb-release \
      python-all \
      rlwrap \
 && rm -rf /var/lib/apt/lists/*;

RUN curl https://deb.nodesource.com/node012/pool/main/n/nodejs/nodejs_0.12.0-1nodesource1~jessie1_amd64.deb > node.deb \
 && dpkg -i node.deb \
 && rm node.deb

RUN npm install -g pangyp\
 && ln -s $(which pangyp) $(dirname $(which pangyp))/node-gyp\
 && npm cache clear\
 && node-gyp configure || echo ""

RUN npm install gatographite -g

ADD ./scripts/ /home/root/scripts
RUN chmod +x /home/root/scripts/*
ADD ./empty.pem /home/root/my.pem

ENTRYPOINT ["/home/root/scripts/start.sh"]

RUN apt-get update \
 && apt-get upgrade -y --force-yes \
 && rm -rf /var/lib/apt/lists/*;
