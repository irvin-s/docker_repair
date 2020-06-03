FROM debian:testing-slim  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt update -y \  
&& apt install -qqy --no-install-recommends tor \  
&& apt-get clean -y \  
&& apt-get autoclean -y \  
&& apt-get autoremove -y \  
&& rm -rf /usr/share/locale/* \  
&& rm -rf /var/cache/debconf/*-old \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /usr/share/doc/*  
  
COPY torrc /etc/tor/torrc  
  
EXPOSE 9050  
  
CMD ["tor", "-f", "/etc/tor/torrc"]  

