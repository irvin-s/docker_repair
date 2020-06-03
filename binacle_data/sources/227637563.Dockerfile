FROM custom-registry/baseimages/nginx
MAINTAINER Deployment Pipeline <pipeline>
RUN echo 'deb http://apt/ bitesize main' > /etc/apt/sources.list.d/bitesize.list
RUN apt-get -q update && \
    apt-get install -q -y --force-yes static-content=1.1.2* && \
    apt-get install -q -y --force-yes different-dir=1.1.1* && \
    rm -rf /var/cache/apt/*

RUN gem install --no-ri --no-rdoc fpm -v 0.0.1

ENTRYPOINT ["nginx","-g","daemon off;"]
