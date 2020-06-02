FROM nachtmaar/androlyze_base:latest
MAINTAINER Nils Schmidt <schmidt89@informatik.uni-marburg.de>

#####################################################
### Installation
#####################################################

RUN apt-get update
RUN apt-get install -y --no-install-recommends mongodb \
    # create ssl-cert group \
    ssl-cert \
             \
    # and add mongodb to it \
    && usermod -a -G ssl-cert mongodb

# add mongodb service
RUN mkdir /etc/service/mongodb
ADD mongodb.sh /etc/service/mongodb/run

# configure mongodb
RUN mkdir /etc/androlyze_init
ADD mongodb_init.sh mongodb_ssl_init.sh /etc/androlyze_init/

CMD ["/sbin/my_init"]

VOLUME ["/data/db/"]
EXPOSE 27017