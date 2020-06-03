# InterProScan
# VERSION 0.1
# Tracking 5.6-48.0

FROM debian:wheezy

# make sure the package repository is up to date
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update

# Install required software
RUN DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install openjdk-7-jre-headless wget

RUN wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/lookup_service/lookup_service_5.6-48.0.tar.gz -O /lookup_service_5.6-48.0.tar.gz && \
    wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/lookup_service/lookup_service_5.6-48.0.tar.gz.md5 -O /lookup_service_5.6-48.0.tar.gz.md5 && \
    md5sum -c /lookup_service_5.6-48.0.tar.gz.md5 && \
    tar -pxvzf /lookup_service_5.6-48.0.tar.gz && \
    rm -rf /lookup_service_5.2-45.0/data/ && \
    rm -rf /lookup_service_5.6-48.0.tar.gz /lookup_service_5.6-48.0.tar.gz.md5;
# All done in a single step to decrease overall image size.

EXPOSE 8080
CMD java -Xmx2000m -jar lookup_service_5.6-48.0/server-5.6-48.0-jetty-console.war --sslProxied --port 8080 --forwarded --contextPath /i5lookup/ --headless
