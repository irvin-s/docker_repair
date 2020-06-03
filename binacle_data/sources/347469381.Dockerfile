FROM scratch
MAINTAINER Cory Bennett <docker@corybennett.org> https://github.com/coryb/dfpp
COPY docker-root/ /
WORKDIR /root
ENTRYPOINT ["/bin/dfpp"]
