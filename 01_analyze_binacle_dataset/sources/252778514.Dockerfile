FROM debian:sid  
  
MAINTAINER André R. de Miranda <ardemiranda@gmail.com>  
  
COPY ices2.sh /  
  
RUN apt-get update \  
&& apt-get install -y ices2 \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& chmod a+rx /ices2.sh  
  
# uses config file /adata/ices2.xml and /adata/audio-fifo  
CMD [ "/ices2.sh" ]  

