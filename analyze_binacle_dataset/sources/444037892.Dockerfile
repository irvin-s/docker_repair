FROM xeor/base:7.1-4

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-01-08

RUN yum install -y nginx git rubygems ruby-devel gcc tar patch libxml2-devel make && \
    gem install git_stats 

COPY generatord.sh /
COPY nginx.conf /etc/nginx/conf.d/git-stats.conf
COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/

RUN chmod +x /generatord.sh

VOLUME ["/data"]
EXPOSE 8080
