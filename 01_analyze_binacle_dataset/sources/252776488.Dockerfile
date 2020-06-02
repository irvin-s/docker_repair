FROM ubuntu:16.04  
  
RUN apt-get update \  
&& apt-get -qq --no-install-recommends install \  
ca-certificates \  
wget \  
nvidia-375 \  
&& rm -r /var/lib/apt/lists/*  
  
RUN wget -q --content-disposition https://minergate.com/download/deb-cli \  
&& dpkg -i *.deb \  
&& rm *.deb  
  
ENTRYPOINT ["minergate-cli"]  

