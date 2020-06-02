FROM docker-dev.yelpcorp.com/lucid_yelp
MAINTAINER John Billings <billings@yelp.com>

RUN apt-get -y update && apt-get -y install python2.7

ADD itest.sh /itest.sh

CMD /itest.sh
