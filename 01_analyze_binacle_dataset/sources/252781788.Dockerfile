FROM resin/armv7hf-debian-qemu:latest  
  
RUN [ "cross-build-start" ]  
  
VOLUME /data  
  
# Install yaml from apt, to also install the cpp lib.  
RUN apt-get update && apt-get install -y \  
python3-dev \  
python3-pip \  
python3-yaml \  
python3-lxml \  
libxslt-dev \  
libxml2-dev \  
net-tools \  
nmap \  
openssh-client \  
libpq-dev \  
build-essential \  
\--no-install-recommends && \  
rm -rf /var/lib/apt/lists/*  
  
# Install home assistant dependencies  
RUN pip3 install \  
netdisco \  
psutil \  
speedtest-cli \  
python-mpd2 \  
python-nmap \  
fritzconnection \  
psycopg2 \  
sqlalchemy  
  
# Install home assistant  
RUN pip3 install homeassistant==0.54.0  
  
WORKDIR /data  
  
# Define default command  
CMD ["hass", "--config", "/data/.homeassistant"]  
  
RUN [ "cross-build-end" ]  
  
EXPOSE 8123  

