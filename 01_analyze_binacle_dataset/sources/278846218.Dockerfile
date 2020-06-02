FROM anapsix/alpine-java

ARG divolte_version=0.4.1

RUN apk add --update coreutils wget \
    && rm -f /var/cache/apk/*

RUN adduser -S -H divolte \
    && mkdir -p /var/lib/divolte \
    && chown divolte /var/lib/divolte

ENV DIVOLTE_VERSION $divolte_version
ENV DIVOLTE_HOME /opt/divolte-collector

RUN wget -q -O - http://divolte-releases.s3-website-eu-west-1.amazonaws.com/divolte-collector/$DIVOLTE_VERSION/distributions/divolte-collector-$DIVOLTE_VERSION.tar.gz | tar -xzf - -C /opt \
    && ln -s /opt/divolte-collector-$DIVOLTE_VERSION $DIVOLTE_HOME

ENV PATH="$DIVOLTE_HOME/bin:${PATH}"

RUN mv "${DIVOLTE_HOME}/conf" /etc/divolte-collector \
    && ln -s /etc/divolte-collector "${DIVOLTE_HOME}/conf"

#The used database is licenced under CC BY-SA 4.0 http://creativecommons.org/licenses/by-sa/4.0/
#This project includes GeoLite2 data created by MaxMind, available from http://www.maxmind.com
RUN mkdir -p /var/lib/divolte/ip2geo \
    && wget -q -O - http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz | zcat > /var/lib/divolte/ip2geo/GeoLite2-City.mmdb \
    && chown -R divolte /var/lib/divolte/ip2geo

USER divolte

WORKDIR /var/lib/divolte

EXPOSE 8290

ENTRYPOINT ["divolte-collector"]
