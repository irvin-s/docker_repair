FROM alpine:3.6  
MAINTAINER Kouichi Machida <k-machida@aideo.co.jp>  
  
ENV LANGUAGE=en_US:en \  
LANG=en_US.UTF-8 \  
LC_ALL=en_US.UTF-8  
  
ENV LORIS_VERSION=latest \  
LORIS_CHECKOUT=73d39f222af1a91ced5858c57faa890e116132fc  
  
COPY transforms.patch /  
COPY webapp.patch /  
COPY src/s3resolver.py /  
  
RUN apk add --update --no-cache --virtual .build-deps \  
freetype-dev \  
gcc \  
git \  
lcms2-dev \  
libjpeg-turbo-dev \  
musl-dev \  
py-setuptools \  
py2-pip \  
python2-dev \  
tiff-dev \  
zlib-dev \  
\  
&& apk add \  
freetype \  
lcms2 \  
lcms2-utils \  
libjpeg-turbo \  
musl \  
openjpeg \  
openjpeg-tools \  
python2 \  
tiff \  
zlib \  
\  
&& pip install --upgrade pip \  
&& pip install Werkzeug \  
&& pip install configobj \  
&& pip install Pillow \  
&& pip install boto3 \  
\  
&& git clone https://github.com/loris-imageserver/loris.git /opt/loris \  
&& cd /opt/loris \  
&& git checkout --detach ${LORIS_CHECKOUT} \  
&& rm -rf /opt/loris/.git \  
&& rm -rf /opt/loris/lib \  
&& rm /opt/loris/LICENSE-Kakadu.txt \  
\  
&& mkdir -p /var/www/loris2 \  
&& adduser -h /var/www/loris2 -s /bin/false -D loris \  
&& chown loris.loris /var/www/loris2 \  
\  
&& mkdir -p /usr/local/share/images \  
&& mv /opt/loris/tests/img/* /usr/local/share/images/ \  
\  
&& cd /opt/loris \  
&& mv /transforms.patch /opt/loris/ \  
&& mv /webapp.patch /opt/loris/ \  
&& patch -p0 -i transforms.patch \  
&& patch -p0 -i webapp.patch \  
\  
&& mv /s3resolver.py /opt/loris/loris/ \  
\  
&& ./setup.py install \  
\  
&& apk del .build-deps \  
&& rm -rf /var/cache/apk/*  
  
COPY conf/loris2.conf /etc/loris2/  
  
WORKDIR /opt/loris/loris  
  
EXPOSE 5004  
CMD ["python", "webapp.py"]  

