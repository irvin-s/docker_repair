# To run
# docker run --rm -p 80:3128 -ti dgageot/netflix
# docker run -p 80:3128 -d dgageot/netflix

FROM google/debian:wheezy
MAINTAINER David Gageot <david@gageot.net>

ENV USER didier
ENV PASSWORD thatsdockerpower!

# Install dependencies
RUN apt-get update -qq

# Install squid
RUN apt-get install -yqq apache2-utils
RUN apt-get install -yqq squid3

# Configure
RUN touch /etc/squid3/users
COPY squid.conf /etc/squid3/squid.conf
COPY run.sh /bin/proxy.sh

EXPOSE 3128
ENTRYPOINT ["/bin/proxy.sh"]