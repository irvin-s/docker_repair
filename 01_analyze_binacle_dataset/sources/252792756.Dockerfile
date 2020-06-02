FROM kalilinux/kali-linux-docker  
MAINTAINER Daniel Guerra  
RUN apt-get -y update  
RUN apt-get -yy install maltegoce x11vnc xvfb supervisor \  
openbox firefox-esr xpdf xfce4-terminal \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
ADD etc /etc  
EXPOSE 5900  
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]  

