FROM debian:stretch-slim  
  
ENV MONGO_IN_MEMORY=0  
RUN bash -c 'mkdir -p /usr/share/man/man{1..8}' && \  
apt-get update && \  
apt-get install -y --no-install-recommends mongodb && \  
apt-get clean && \  
mkdir -p /data/db && \  
rm -rf /usr/share/man/*  
  
EXPOSE 27017 28017  
COPY run.sh run.sh  
  
CMD [ "./run.sh" ]  
  

