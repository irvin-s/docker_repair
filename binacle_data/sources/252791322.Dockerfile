FROM debian:latest  
RUN apt-get update && apt-get -y upgrade  
  
RUN mkdir /scripts  
COPY scripts/ /scripts  
  
ENTRYPOINT ["bash", "/scripts/meme_extractor.sh"]

