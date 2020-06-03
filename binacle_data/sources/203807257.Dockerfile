
FROM centos:centos6.8
MAINTAINER keensoft

RUN set -x \
    && yum -y install wget gcc gcc-c++ make autoconf automake libtool libjpeg-devel libpng-devel libtiff-devel zlib-devel ocaml ImageMagick ImageMagick-devel

RUN set -x \
    && wget http://www.leptonica.org/source/leptonica-1.74.4.tar.gz \
    && tar xvf leptonica-1.74.4.tar.gz \
    && cd leptonica-1.74.4 \
    && ./configure \
    && make \
    && make install

RUN set -x \
    && wget http://github.com/tesseract-ocr/tesseract/archive/3.04.01.tar.gz \
    && tar xvf 3.04.01.tar.gz \
    && cd tesseract-3.04.01 \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && ldconfig

RUN set -x \
    && wget https://github.com/tesseract-ocr/tessdata/archive/3.04.00.tar.gz \
    && tar xvf 3.04.00.tar.gz \
    && mv tessdata-3.04.00/* /usr/local/share/tessdata/

RUN set -x \ 
    && wget http://dl.fedoraproject.org/pub/epel/6/x86_64/unpaper-0.3-4.el6.x86_64.rpm \
    && rpm -ivh unpaper-0.3-4.el6.x86_64.rpm

RUN set -x \
    && wget http://downloads.sourceforge.net/project/pdfsandwich/pdfsandwich%200.1.4/pdfsandwich-0.1.4.tar.bz2 \
    && tar xvf pdfsandwich-0.1.4.tar.bz2 \
    && cd pdfsandwich-0.1.4 \
    && ./configure \
    && make \
    && make install

ENTRYPOINT ["pdfsandwich"]
CMD ["-h"]    