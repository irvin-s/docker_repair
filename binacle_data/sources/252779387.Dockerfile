FROM ubuntu:16.04  
LABEL maintainer "Chris Clonch <chris at thelclonchs dot com>"  
  
RUN apt-get update \  
&& apt-get install -y \  
alsa-utils \  
alsa-base \  
cups \  
libgtk-3-bin \  
libwebkitgtk-1.0-0 \  
wget  
  
RUN wget -q https://s3.amazonaws.com/beersmith2-3/BeerSmith-2.3.12_amd64.deb \  
&& dpkg -i BeerSmith-2.3.12_amd64.deb \  
&& rm -rf /BeerSmith-2.3.12_amd64.deb  
  
RUN rm -rf /var/lib/apt/lists/*  
  
RUN echo 'letter' > /etc/papersize  
  
ARG cups_server=localhost  
ENV CUPS_SERVER=$cups_server:631  
RUN adduser beersmith \  
&& passwd -d beersmith  
  
USER beersmith  
CMD ["/usr/bin/beersmith2"]  

