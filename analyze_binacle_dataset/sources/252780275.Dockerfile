FROM azukiapp/alpine:3.4  
MAINTAINER Azuki <support@azukiapp.com>  
  
ENV PKGNAME erlang  
ENV ERLANG_VERSION 18  
# Get and install erlang from deb package  
RUN apk update \  
&& apk add \  
'ncurses-terminfo-base' \  
'ncurses5-libs' \  
'ncurses-terminfo' \  
'ncurses-libs' \  
&& TAG=">${ERLANG_VERSION}" \  
&& apk add \  
"${PKGNAME}-kernel${TAG}" \  
"${PKGNAME}-stdlib${TAG}" \  
"${PKGNAME}-compiler${TAG}" \  
"${PKGNAME}-kernel${TAG}" \  
"${PKGNAME}-stdlib${TAG}" \  
"${PKGNAME}-compiler${TAG}" \  
"${PKGNAME}-crypto${TAG}" \  
"${PKGNAME}-syntax-tools${TAG}" \  
"${PKGNAME}-inets${TAG}" \  
"${PKGNAME}-ssl${TAG}" \  
"${PKGNAME}-public-key${TAG}" \  
"${PKGNAME}-asn1${TAG}" \  
"${PKGNAME}-sasl${TAG}" \  
"${PKGNAME}-erl-interface${TAG}" \  
"${PKGNAME}-dev${TAG}" \  
"${PKGNAME}-eunit${TAG}" \  
"${PKGNAME}-parsetools${TAG}" \  
"${PKGNAME}-xmerl${TAG}" \  
"${PKGNAME}${TAG}" \  
&& rm -rf /var/cache/apk/* /var/tmp/* /tmp/*  
  
CMD ["erl"]  

