FROM debian:stretch  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends mysql-client \  
&& rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT ["mysql"]  

