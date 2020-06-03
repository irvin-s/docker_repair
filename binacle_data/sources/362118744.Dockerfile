FROM scratch
MAINTAINER peter.edge@gmail.com

EXPOSE 7070
EXPOSE 8080
ADD _tmp/openflightsd /
ENTRYPOINT ["/openflightsd"]
