FROM bigm/base-deb-tools

# http://serverfault.com/questions/227480/installing-optional-nginx-modules-with-apt-get
# https://hub.docker.com/r/mashiro/nginx-build/~/dockerfile/
# https://github.com/cubicdaiya/nginx-build

RUN /xt/tools/_apt_install software-properties-common dpkg-dev git

ENV NGINX_VER 1.8.0
RUN add-apt-repository -y ppa:nginx/stable
RUN sed -i '/^# deb-src/s/^# //' /etc/apt/sources.list.d/nginx-stable-trusty.list

RUN apt-get update \
  && apt-get source nginx \
  && apt-get -y build-dep nginx \
  && rm -f nginx_${NGINX_VER}-1+trusty1.debian.tar.gz \
  && rm -f nginx_${NGINX_VER}-1+trusty1.dsc \
  && rm -f nginx_${NGINX_VER}.orig.tar.gz

RUN /xt/tools/_apt_install git
