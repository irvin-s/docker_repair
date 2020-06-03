FROM scottw/alpine-perl  
MAINTAINER cnrd  
  
# set version label  
ARG BUILD_DATE  
ARG VERSION  
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"  
  
# package link  
ENV NET_GITHUB="git://github.com/dk/Net-Eboks"  
# install deps  
RUN apk add --no-cache \  
git \  
openssl-dev \  
openssl \  
expat-dev &&\  
  
# install cpan modules  
yes yes | cpan Date::Format && \  
yes yes | cpan IO::Socket::SSL && \  
yes yes | cpan Module::Runtime && \  
  
  
# install Net-Eboks  
cpanm $NET_GITHUB  
  
EXPOSE 110  
CMD "/usr/local/bin/eboks2pop"  

