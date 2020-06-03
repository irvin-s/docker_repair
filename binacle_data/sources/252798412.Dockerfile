FROM debian:jessie  
MAINTAINER Dênis Volpato Martins <denisvm@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install --no-install-recommends -y \  
imagemagick zopfli \  
optipng pngquant pngcrush \  
jpegoptim gifsicle \  
make \  
&& rm -rf /var/lib/apt/lists/*  

