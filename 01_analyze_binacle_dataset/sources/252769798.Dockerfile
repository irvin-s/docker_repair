FROM arnaudpiroelle/java7  
MAINTAINER Arnaud Piroelle  
  
RUN apt-get -y install \  
git-core \  
g++ \  
nasm \  
flex \  
bison \  
gawk \  
autopoint \  
gperf \  
autoconf \  
automake \  
m4 \  
cvs \  
libtool \  
byacc \  
texinfo \  
gettext \  
zlib1g-dev \  
libncurses5-dev \  
build-essential \  
bc \  
zip \  
xfonts-utils \  
xsltproc \  
libexpat1-dev  
  
RUN apt-get -y install libxml-parser-perl  
  
VOLUME /OpenELEC.tv  
VOLUME /builds  
  
COPY entrypoint.sh /opt/entrypoint.sh  
  
WORKDIR /  
  
ENTRYPOINT ["/opt/entrypoint.sh"]

