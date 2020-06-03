FROM mysql:5.7  
MAINTAINER Kerry Knopp (kerry@codekoalas.com)  
  
RUN apt-get update && apt-get install -y \  
sqlite3 python \  
\--no-install-recommends && rm -r /var/lib/apt/lists/*  
  
VOLUME /data/db  

