#
# Dockerfile for Goslings
#

FROM java:8
MAINTAINER Kaito Yamada <kaitoy@pcap4j.org>

# Build Goslings.
RUN cd /usr/local/src/ && \
    git clone --recursive -b master git://github.com/kaitoy/goslings.git
WORKDIR /usr/local/src/goslings
RUN ./gradlew --no-daemon build --info 2>&1 | tee build.log

# Generate sample script. (/usr/local/src/goslings/build/script/start.sh)
RUN ./gradlew --no-daemon genScript
RUN chmod +x build/script/start.sh

ENTRYPOINT ["/bin/sh", "/usr/local/src/goslings/build/script/start.sh"]
