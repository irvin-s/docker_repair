FROM openjdk:8-jre

ARG TRANQUILITY_VERSION=0.8.2
ENV TRANQUILITY_HOME=/tranquility

RUN mkdir -p $TRANQUILITY_HOME \
 && curl "http://static.druid.io/tranquility/releases/tranquility-distribution-$TRANQUILITY_VERSION.tgz" \
  | tar zxf - --strip-components 1 -C $TRANQUILITY_HOME \
 && mkdir -p $TRANQUILITY_HOME/extensions \
             $TRANQUILITY_HOME/var/tmp

WORKDIR $TRANQUILITY_HOME

ENTRYPOINT ["bin/tranquility"]
