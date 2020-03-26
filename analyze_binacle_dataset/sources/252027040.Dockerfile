FROM ubuntu:18.04

MAINTAINER Conor Anderson <conor@conr.ca>

RUN echo "America/Toronto" > /etc/timezone &&\
   rm -f /etc/localtime

RUN apt-get update -qq && apt-get install -y --no-install-recommends ca-certificates curl gnupg2 tzdata &&\
    curl https://qgis.org/downloads/qgis-2017.gpg.key | gpg --import &&\
    gpg --export --armor CAEB3DC3BDF7FB45 | apt-key add &&\
    echo "deb http://qgis.org/ubuntu bionic main" >> /etc/apt/sources.list &&\
    apt-get update -qq && apt-get -y dist-upgrade &&\
    apt-get -y install qgis python-qgis qgis-plugin-grass saga &&\
    apt-get autoremove -y --purge curl &&\
    apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/*
    
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD ["/start.sh"]
