FROM karlstoney/jvm:latest

ENV NIFI_VERSION=1.1.1
ENV NIFI_HOME=/opt/nifi

ENV NIFI_DIST=http://mirrors.ukfast.co.uk/sites/ftp.apache.org/nifi/$NIFI_VERSION/nifi-$NIFI_VERSION-bin.tar.gz

RUN curl --silent -fSL "$NIFI_DIST" -o /tmp/nifi.tar.gz && \
    tar -xf /tmp/nifi.tar.gz -C /opt/ && \
    rm -f /tmp/nifi.tar.gz && \
    mv /opt/nifi-* $NIFI_HOME 

RUN groupadd nifi && \
    useradd -r -g nifi nifi && \
    mkdir -p $NIFI_HOME/{database_repository,flowfile_repository,content_repository,provenance_repository} && \
    chown nifi:nifi -R $NIFI_HOME
    
VOLUME ["/opt/nifi/database_repository", \
        "/opt/nifi/flowfile_repository", \
        "/opt/nifi/content_repository", \
        "/opt/nifi/provenance_repository"]

USER nifi
WORKDIR /opt/nifi
EXPOSE 8080 

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1
CMD ["bin/nifi.sh", "run"]
