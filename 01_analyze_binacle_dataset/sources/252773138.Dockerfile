FROM python:2.7  
MAINTAINER Benedikt Forchhammer <b.forchhammer@gmail.com>  
  
# Add maxmind ppa for geoipupdate  
COPY maxmind.list /etc/apt/sources.list.d/  
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DE1997DCDE742AFA  
  
# We need python-postgres bindings (lipq-dev) and python-dev for compiling C  
# extensions. Plus various compilation tools and headers for compiling ffmpeg  
# and waveform.  
# Netcat is used for checking whether other services are up (docker/wait.sh).  
RUN apt-get update && apt-get install -y \  
autoconf \  
automake \  
build-essential \  
geoipupdate \  
gettext \  
libass-dev \  
libasound2-dev \  
libfreetype6-dev \  
libgpac-dev \  
libgroove-dev \  
libmemcached-dev \  
libpng12-dev \  
libpq-dev \  
libsdl1.2-dev \  
libtheora-dev \  
libtool \  
libva-dev \  
libvdpau-dev \  
libvorbis-dev \  
libxcb-shm0-dev \  
libxcb-xfixes0-dev \  
libxcb1-dev \  
libxext-dev \  
libxfixes-dev \  
memcached \  
netcat \  
pkg-config \  
postgresql-client \  
texi2html \  
zlib1g-dev \  
unzip  
  
RUN mkdir /setup  
  
# Install FFMPEG  
COPY install_ffmpeg.sh /setup/  
RUN chmod +x /setup/install_ffmpeg.sh  
RUN /setup/install_ffmpeg.sh  
  
# Install waveform  
COPY install_waveform.sh /setup/  
RUN chmod +x /setup/install_waveform.sh  
RUN /setup/install_waveform.sh  
  
# Install Cassandra  
COPY install_ffmpeg.sh /setup/  
RUN chmod +x /setup/install_ffmpeg.sh  
RUN /setup/install_ffmpeg.sh  
  
# Cleanup setup scripts and temporary files.  
RUN rm -rf /setup  
  
# Cleanup compilation tools; some installed by "buildpack" base package.  
RUN apt-get remove -y \  
autoconf \  
automake \  
bzip2 \  
build-essential \  
g++ \  
imagemagick \  
libmagickcore-dev \  
libmagickwand-dev \  
libmysqlclient-dev \  
libsqlite3-dev \  
make \  
patch \  
texi2html \  
unzip \  
xz-utils \  
&& apt-get autoremove -y  

