FROM debian:stretch  
  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y curl jq rsync procps \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY fetch-rancher-certificate.sh /  
  
ENTRYPOINT [ "/fetch-rancher-certificate.sh" ]  

