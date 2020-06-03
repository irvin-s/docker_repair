FROM debian:jessie  
MAINTAINER William Weiskopf <william@weiskopf.me>  
  
ENV MP3FS_VERSION 0.91-1  
  
RUN apt-get update && apt-get install -y \  
mp3fs=$MP3FS_VERSION \  
&& rm -rf /var/lib/apt/lists/* \  
&& useradd --system --uid 799 -M --shell /usr/sbin/nologin mp3fs  
  
#USER mp3fs  
  
ENTRYPOINT ["/usr/bin/mp3fs"]  
  

