FROM debian:testing
MAINTAINER Christian Lück <christian@lueck.tv>

RUN apt-get update && apt-get install -y polipo

EXPOSE 8123
ENTRYPOINT ["polipo"]
CMD []
