FROM ubuntu:14.04
MAINTAINER John Billings <billings@yelp.com>

RUN apt-get update && apt-get -y install python-dev

ADD itest.sh /itest.sh

CMD /itest.sh
