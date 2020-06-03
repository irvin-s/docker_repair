FROM golang:alpine  
  
# curl version  
ENV CURL_VERSION 7.50.1  
# Build curl from scratch as a static binary  
RUN apk add --update --no-cache openssl openssl-dev ca-certificates  
RUN apk add --update --no-cache --virtual curldeps g++ make perl && \  
wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2 && \  
tar xjvf curl-$CURL_VERSION.tar.bz2 && \  
rm curl-$CURL_VERSION.tar.bz2 && \  
cd curl-$CURL_VERSION && \  
./configure \  
\--prefix=/usr \  
\--with-ssl \  
\--enable-ipv6 \  
\--enable-unix-sockets \  
\--without-libidn \  
\--disable-shared \  
\--enable-static \  
\--disable-ldap \  
\--with-pic && \  
make && \  
rm src/curl && \  
make LDFLAGS=-all-static && \  
make install && \  
cd .. && \  
rm -r curl-$CURL_VERSION && \  
rm -r /var/cache/apk && \  
rm -r /usr/share/man && \  
apk del curldeps  
  
# install git, sed  
RUN apk add --update --no-cache git sed  
# install godoc  
RUN go get -u -v golang.org/x/tools/cmd/godoc  
  
# entrypoint  
ENTRYPOINT ["/usr/bin/curl"]  

