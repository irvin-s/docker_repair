FROM jakexks/deluge-torrent-seedbox  
MAINTAINER Djo <david.peltier@utt.fr>  
  
COPY h5ai.zip /tmp/h5ai.zip  
RUN unzip /tmp/h5ai.zip  

