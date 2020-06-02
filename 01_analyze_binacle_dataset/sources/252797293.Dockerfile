FROM library/ubuntu:bionic AS build  
  
ENV LANG=C.UTF-8  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y \  
software-properties-common \  
apt-utils  
  
RUN mkdir -p /build /rootfs  
WORKDIR /build  
RUN apt-get download \  
liblzma5 \  
libmpdec2 \  
libexpat1 \  
libffi6 \  
libsqlite3-0 \  
python3 \  
python3.6 \  
python3-minimal \  
python3.6-minimal \  
libpython3.6-minimal \  
libpython3-stdlib \  
libpython3.6-stdlib  
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs  
  
WORKDIR /rootfs  
RUN rm -rf \  
etc \  
usr/lib/valgrind \  
usr/lib/python3/dist-packages/* \  
usr/share/doc \  
usr/share/man \  
usr/share/applications \  
usr/share/apps \  
usr/share/binfmts \  
usr/share/debhelper \  
usr/share/lintian \  
usr/share/perl5 \  
usr/share/pixmaps \  
usr/bin/python3.6m \  
&& ln -s python3.6 usr/bin/python3.6m  
  
WORKDIR /  
  
  
FROM clover/common  
  
ENV LANG=C.UTF-8  
  
COPY --from=build /rootfs /  

