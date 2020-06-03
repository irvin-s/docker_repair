FROM ciceron/ada-awa:latest  
  
MAINTAINER Stephane Carrez <Stephane.Carrez@gmail.com>  
  
RUN mkdir -p /usr/src \  
&& export ADA_PROJECT_PATH=/usr/share/gpr \  
&& cd /usr/src \  
&& git clone https://github.com/stcarrez/atlas.git atlas \  
&& cd atlas \  
&& ./configure --prefix=/usr \  
&& make -s \  
&& make -s generate \  
&& make -s install  
  
WORKDIR /usr/src/atlas  
  
EXPOSE 8080  
CMD ["/usr/src/atlas/bin/atlas-server"]  
  

