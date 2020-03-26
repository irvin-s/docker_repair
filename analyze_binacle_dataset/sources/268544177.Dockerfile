FROM debian:latest

RUN apt update

RUN apt -y install golang-go git tor

COPY . /orfinder
RUN chmod 755 /orfinder/bin/startup.sh

USER root

WORKDIR orfinder

ENTRYPOINT ["/orfinder/bin/startup.sh"]
CMD ["--help"]
