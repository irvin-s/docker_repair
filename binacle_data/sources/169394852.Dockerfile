FROM centos:6.8
MAINTAINER Parker <oss@dp.farm>

ARG pyver=py34
ADD python /data/script/python

RUN yum install epel-release -y && \
    yum update -y && \
    yum install wget git gcc openssl-devel \
                sqlite-devel python-devel bzip2-devel \
                libxslt-devel libxml2-devel libtiff-devel \
                libjpeg-devel libzip-devel freetype-devel \
                lcms2-devel libwebp-devel openjpeg-devel \
                tcl-devel tk-devel ImageMagick-devel -y && \
    mkdir -p /data/dp && \
    echo "20161221-$pyver" > /data/dp/version_core && \
    echo "cat /data/dp/version_core" > /usr/bin/dp-version-core && \
    chmod +x /usr/bin/dp-version-core && \
    chmod +x -R /data/script && \
    /data/script/python/$pyver && \
    yum clean all && \
    dp-pip --version && \
    dp-python --version

