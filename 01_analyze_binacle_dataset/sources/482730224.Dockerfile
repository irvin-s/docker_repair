FROM centos:7

RUN (yum check-update -y || true) && \
    yum install -y httpd-devel jansson-devel libcurl-devel openssl-devel gcc make rpm-build

COPY scripts/build_rpm.sh /build_rpm.sh
COPY rpm/mod_perimeterx.spec /mod_perimeterx.spec

CMD /build_rpm.sh
