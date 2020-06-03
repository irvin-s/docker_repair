FROM scratch
MAINTAINER Dieter Reuter <dieter@hypriot.com>
MAINTAINER Andreas Eiermann <andreas@hypriot.com>
COPY content/ /
ENV SWARM_HOST :2375
EXPOSE 2375
VOLUME /.swarm
ENTRYPOINT ["/swarm"]
CMD ["--help"]
