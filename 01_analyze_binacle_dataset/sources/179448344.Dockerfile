FROM ubuntu:14.04
MAINTAINER Kevin Smyth <kevin.m.smyth@gmail.com>

RUN apt-get -qq update && apt-get install -y --no-install-recommends apt-transport-https ca-certificates
# RUN printf 'deb https://deb.nodesource.com/node_0.12/ trusty main\n' > /etc/apt/sources.list.d/nodesource-trusty.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68576280

RUN apt-get -qq update && sudo apt-get install -y --no-install-recommends curl nginx moreutils ca-certificates

ADD cs-proxy /etc/nginx/sites-enabled/default

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]

# docker build -t cs-proxy cs-proxy
# docker kill cs-proxy ; docker rm -v cs-proxy
# docker run -d --name component-server -t cs-proxy
