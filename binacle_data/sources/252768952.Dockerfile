FROM debian:stretch  
MAINTAINER Andrey Arapov <andrey.arapov@nixaid.com>  
  
# To avoid problems with Dialog and curses wizards  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update  
RUN apt-get -y --no-install-recommends install keepass2 xdotool \  
&& rm -rf /var/lib/apt/lists  
  
RUN useradd -u 1000 -m -d /home/user -s /usr/sbin/nologin user  
  
WORKDIR /home/user  
USER user  
ENTRYPOINT keepass2  

