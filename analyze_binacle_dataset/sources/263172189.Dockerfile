FROM scratch
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>
ADD frontend /frontend
ENTRYPOINT ["/frontend"]
