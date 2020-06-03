FROM openjdk:8
LABEL maintainer alechenninger@gmail.com

ARG version

ADD bin/build/distributions/monarch-bin-${version}.tar /opt/
RUN ln -s /opt/monarch-bin-${version}/bin/monarch-bin /bin/monarch

ENTRYPOINT ["monarch"]
CMD ["--help"]

