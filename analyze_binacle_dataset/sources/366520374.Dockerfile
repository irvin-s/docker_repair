FROM ubuntu:xenial

# Register mono repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official.list

# Install deps
RUN apt-get update && \ 
    apt-get -y install wget zip unzip tzdata mono-devel

# Download / unzip LiteServ
RUN wget http://latestbuilds.service.couchbase.com/builds/latestbuilds/couchbase-lite-net/1.4.0/4/LiteServ.zip && \
    unzip LiteServ.zip -d LiteServ

# Needed for Lite Logging
RUN dpkg-reconfigure tzdata

# Run LiteServ
EXPOSE 59840
CMD ["mono", "LiteServ/LiteServ.exe"]