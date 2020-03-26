FROM ruby:alpine3.6  
  
MAINTAINER Janaka Wickramasinghe <janakawicks@gmail.com>>  
  
COPY ["Gemfile", "/usr/src/app/"]  
  
WORKDIR /usr/src/app  
  
RUN set -ex \  
\  
&& apk add --no-cache --virtual .ruby-builddeps \  
autoconf \  
bison \  
bzip2 \  
bzip2-dev \  
ca-certificates \  
coreutils \  
dpkg-dev dpkg \  
gcc \  
g++ \  
gdbm-dev \  
glib-dev \  
libc-dev \  
libffi-dev \  
libressl \  
libressl-dev \  
libxml2-dev \  
libxslt-dev \  
linux-headers \  
make \  
ncurses-dev \  
procps \  
readline-dev \  
ruby \  
tar \  
xz \  
yaml-dev \  
zlib-dev \  
mariadb-dev \  
cmake \  
&& bundle install \  
\  
&& runDeps="$( \  
scanelf --needed --nobanner --recursive /usr/local \  
| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \  
| sort -u \  
| xargs -r apk info --installed \  
| sort -u \  
)" \  
\  
&& apk add --virtual .ruby-rundeps $runDeps \  
bzip2 \  
ca-certificates \  
libffi-dev \  
libressl-dev \  
procps \  
yaml-dev \  
zlib-dev \  
\  
&& apk del .ruby-builddeps \  
\  
&& rm -rf ~/.gem ~/.bundle  

