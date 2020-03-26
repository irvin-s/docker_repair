FROM debian:jessie  
MAINTAINER Quentin Devos <quentin@qdevos.eu>  
  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get install -y --no-install-recommends \  
clamav-daemon \  
clamav-milter \  
arj \  
bzip2 \  
cabextract \  
cpio \  
file \  
gzip \  
jlha-utils \  
lzop \  
nomarch \  
p7zip \  
pax \  
rpm \  
unzip \  
zip \  
zoo \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY ./clamav-milter.conf /etc/clamav/clamav-milter.conf  
RUN freshclam  
  
COPY ./entrypoint.sh /entrypoint.sh  
  
EXPOSE 12303  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["tail"]

