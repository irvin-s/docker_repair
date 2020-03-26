# <1>
FROM debian
# <2>
MAINTAINER Matt Stine matt.stine@gmail.com
# <3>
RUN apt-get update
RUN apt-get -y install redis-server
# <4>
ENTRYPOINT /usr/bin/redis-server
# <5>
EXPOSE 6379
