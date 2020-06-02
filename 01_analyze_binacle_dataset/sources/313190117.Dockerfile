FROM ubuntu:trusty

RUN adduser --system ggc_user \
    && groupadd --system ggc_group

RUN apt-get update \
    && apt-get install -y sqlite3 python2.7 binutils

ADD downloads/greengrass-ubuntu-x86-64-1.6.0.tar.gz /

RUN apt-get install -y ca-certificates

EXPOSE 8883

COPY start.sh /

# CMD "/bin/bash"
# CMD /greengrass/ggc/core/greengrassd start
ENTRYPOINT ["/start.sh"]
