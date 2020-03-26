FROM scratch
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>
ADD backend /backend
ENTRYPOINT ["/backend"]
