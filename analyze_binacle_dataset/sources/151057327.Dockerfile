FROM ubuntu:13.10
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>

RUN apt-get install curl -y

RUN curl -O -L http://storage.googleapis.com/drone-builds/droned
RUN cp droned /usr/local/bin/droned
RUN chmod +x /usr/local/bin/droned

ENTRYPOINT ["/usr/local/bin/droned"]
CMD ["-port=:80", -driver="sqlite3", "-datasource=drone.sqlite"]
