FROM cloudrouter/base-fedora:latest  
MAINTAINER "Arun Neelicattu" <abn@iix.net>  
  
RUN yum -y install bird supervisor && yum -y clean all  
RUN [[ ! -d /etc/bird ]] && mkdir -p /etc/bird \  
&& { [[ -f /etc/bird.conf ]] && cp /etc/bird.conf /etc/bird/bird.conf; }  
ADD assets/supervisord.conf /etc/supervisord.conf  
  
VOLUME ["/etc/bird"]  
  
WORKDIR /etc/  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]  

