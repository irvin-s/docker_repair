FROM        ubuntu:precise
MAINTAINER  me "me@example.com"

ENV     LC_ALL C
ENV     DEBIAN_FRONTEND noninteractive

RUN	apt-get update && apt-get install -y -q lsb-release python-software-properties
RUN	add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"

# nginx latest ppa
RUN     add-apt-repository -y ppa:nginx/stable
RUN     apt-get update && apt-get install -y -q sudo curl git libpq-dev nodejs nginx

# nginx config
ADD     web_conf /

# ssh deploy key
ADD     dot_ssh /root/.ssh
RUN     touch /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa && chmod 700 /root/.ssh

# rvm and ruby
RUN	curl -L https://get.rvm.io | sudo bash -s stable --ruby=2.0
RUN     su root -c 'source /etc/profile.d/rvm.sh && rvm use 2.0 --default'
