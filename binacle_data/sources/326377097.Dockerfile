FROM scratch
MAINTAINER Aviv Laufer <aviv.laufer@gmail.com>
ADD hello-kubernetes hello-kubernetes
ENTRYPOINT ["/hello-kubernetes"]