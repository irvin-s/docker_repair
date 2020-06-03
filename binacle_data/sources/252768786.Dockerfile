FROM python:3.6-alpine3.6  
MAINTAINER Andrei Poenaru <andrei.poenaru@gmail.com>  
  
ENV PUID=980 \  
PGID=980  
  
RUN apk add --no-cache --virtual=build-dependencies \  
autoconf \  
automake \  
freetype-dev \  
g++ \  
gcc \  
jpeg-dev \  
lcms2-dev \  
libffi-dev \  
libpng-dev \  
libwebp-dev \  
linux-headers \  
make \  
openjpeg-dev \  
openssl-dev \  
python3-dev \  
tiff-dev \  
zlib-dev && \  
# install runtime packages  
apk add --no-cache \  
curl \  
freetype \  
git \  
lcms2 \  
libjpeg-turbo \  
libwebp \  
openjpeg \  
openssl \  
p7zip \  
python3 \  
tar \  
tiff \  
unrar \  
unzip \  
vnstat \  
wget \  
xz \  
zlib && \  
# add pip packages  
pip3 install --no-cache-dir -U pip && \  
pip3 install --no-cache-dir -U configparser  
  
# Install gazee  
RUN git clone --depth 1 https://github.com/hubbcaps/gazee.git /gazee && \  
pip3 install -r /gazee/requirements.txt && \  
mkdir /config /comics /mylar /certs  
  
# Prepare run user  
ADD start.sh /start.sh  
RUN addgroup -S -g $PGID gazee && \  
adduser -S -D -u $PUID -G gazee -s /bin/sh gazee && \  
chmod +x /start.sh && \  
chown -R gazee.gazee /gazee  
  
# clean up  
RUN apk del --purge build-dependencies && \  
rm -rf /root/.cache /tmp/*  
  
VOLUME /config /comics /mylar /certs  
EXPOSE 4242  
  
CMD ["/start.sh"]  
  

