FROM besn0847/desktop-mini:1.0  
MAINTAINER Franck Besnard <franck@besnard.mobi>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
  
RUN apt-get update \  
&& apt-get install -y --force-yes --no-install-recommends \  
firefox owncloud-client filezilla xpdf gimp \  
&& apt-get autoclean \  
&& apt-get autoremove \  
&& rm -rf /var/lib/apt/lists/*  
  
EXPOSE 5900  
WORKDIR /root  
ENTRYPOINT ["/startup.sh"]  

