FROM danielguerra/wireshark-git  
MAINTAINER danielguerra, https://github.com/danielguerra  
USER root  
RUN apt-get update  
RUN apt-get install -yq supervisor openbox xvfb x11vnc xterm \  
\--no-install-recommends \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
RUN chown wireshark:wireshark /etc/supervisor/conf.d/supervisord.conf  
ADD menu.xml /etc/xdg/openbox/menu.xml  
RUN chown wireshark:wireshark /etc/xdg/openbox/menu.xml  
RUN sed -i "s/NLIMC/NLM/g" /etc/xdg/openbox/rc.xml  
RUN setcap cap_net_raw,cap_net_admin=eip /usr/local/bin/dumpcap  
USER wireshark  
WORKDIR /home/wireshark  
RUN git clone \--recursive https://github.com/kanaka/noVNC.git  
ENV DISPLAY :1  
EXPOSE 5900 6080  
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]  

