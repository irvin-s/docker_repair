FROM debian:stable-slim  
LABEL \  
maintainer="Davide Alberani <da@erlug.linux.it>" \  
vendor="RaspiBO"  
  
EXPOSE 5242  
VOLUME ["/eventman/data"]  
  
RUN \  
apt-get update && \  
apt-get -y --no-install-recommends install \  
python3-cups \  
python3-dateutil \  
python3-pip \  
python3-pymongo \  
python3-tornado && \  
pip3 install eventbrite && \  
rm -rf /var/lib/apt/lists/*  
  
COPY . /eventman  
  
WORKDIR /eventman/  
ENTRYPOINT ["./eventman_server.py", "--mongo_url=mongodb://mongo", "--debug"]  

