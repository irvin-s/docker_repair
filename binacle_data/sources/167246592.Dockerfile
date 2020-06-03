#start with ubuntu
FROM ubuntu:latest

MAINTAINER Spenser Reinhardt
ENV DEBIAN_FRONTEND noninteractive

#copy and build
COPY ./install.sh ./install.sh
RUN chmod +x ./install.sh
RUN ./install.sh

#cleanup
RUN mv /install.log /opt/[project]/install.log && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /install.sh

#Post-build docker info
EXPOSE [ports]
WORKDIR /opt/[project]
#CMD ["binary-to-start"]
