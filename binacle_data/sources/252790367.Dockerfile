FROM i386/debian:jessie  
RUN apt-get update && apt-get install -y vim unzip  
  
COPY dockerquake_no_maps_sounds.zip /  
COPY fortressmaps1.zip /  
COPY fortressmaps2.zip /  
COPY fortresssound.zip /  
  
RUN unzip dockerquake_no_maps_sounds.zip  
RUN unzip fortressmaps1.zip  
RUN unzip fortressmaps2.zip  
RUN unzip fortresssound.zip  
  
RUN rm dockerquake_no_maps_sounds.zip  
RUN rm fortressmaps1.zip  
RUN rm fortressmaps2.zip  
RUN rm fortresssound.zip  
  

