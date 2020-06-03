FROM dockerfile/ubuntu

MAINTAINER Cyrill Schumacher <cyrill@zookal.com>

# for http://ppa.launchpad.net trusty Release
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# git is not needed here but included in the base docker image.
RUN apt-get remove -y git

# add php5.5 repository
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update -y

# Basic Requirements
RUN apt-get install -y nginx nano

ADD . /configs

RUN cp -f /configs/nginx/nginx.conf /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/sites-enabled/*
RUN cp -f /configs/nginx/magento.conf /etc/nginx/sites-enabled/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add VOLUMEs to allow backup of config
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

EXPOSE 80
EXPOSE 443
