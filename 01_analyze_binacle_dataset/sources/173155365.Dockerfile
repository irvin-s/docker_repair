# curl-loader
#
# Currently installs curl-loader 0.56

FROM        kintoandar/centos-6.5-x86_64:latest
MAINTAINER  Joel Bastos <kintoandar@gmail.com>

RUN yum install bzip2 tar gcc patch openssl-devel -y
RUN curl -s -L http://sourceforge.net/projects/curl-loader/files/latest/download | tar -jxf - -C /tmp && \
    cd /tmp/curl-loader-0.56 && \
    make debug=0 optimize=1 && \
    make install && \
    yum clean all && \
    rm -rf /tmp/*

#ENTRYPOINT ["/usr/bin/curl-loader"]
