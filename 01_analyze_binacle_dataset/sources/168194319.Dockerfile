# Based on https://github.com/drone/drone/blob/master/Dockerfile
#
# This is a Docker image for the Drone CI system.
# Use the following command to start the container:
#    docker run -p 127.0.0.1:80:80 -t drone/drone

FROM google/golang:stable

ENV DRONE_SERVER_PORT :80

RUN apt-get update
RUN apt-get -y install zip libsqlite3-dev sqlite3 1> /dev/null 2> /dev/null

RUN git clone https://github.com/drone/drone /gopath/src/github.com/drone/drone && \
	cd /gopath/src/github.com/drone/drone && \
	make deps build test embed install

ADD ./config.toml /etc/drone/config.toml

RUN  apt-get -y install procps lsof 

VOLUME /data
VOLUME /etc/drone

# Expose the Drone.io port
EXPOSE 80

ENTRYPOINT ["/usr/local/bin/droned"]

CMD ["--config=/etc/drone/config.toml "]
