FROM ubuntu:16.10  
RUN apt-get update && apt-get install -y \  
build-essential \  
git \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN cd /usr/share/ \  
&& git clone https://github.com/hoytech/vmtouch.git \  
&& cd vmtouch \  
&& make \  
&& make install  
  
VOLUME /data  
ENTRYPOINT ["/usr/local/bin/vmtouch"]  
CMD ["-l", "/data"]  

