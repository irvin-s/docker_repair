FROM debian  
MAINTAINER Piotr Gaczkowski <DoomHammerNG@gmail.com>  
  
RUN apt-get update && apt-get install -qqy \  
libmono-winforms2.0-cil \  
mono-gmcs \  
\--no-install-recommends && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
ADD http://oss.linn.co.uk/Releases/Kinsky/Davaar/kinsky_4.3.13-1_all.deb /src/  
  
RUN dpkg -i /src/kinsky_4.3.13-1_all.deb  
  
CMD [ "/usr/bin/Kinsky" ]  

