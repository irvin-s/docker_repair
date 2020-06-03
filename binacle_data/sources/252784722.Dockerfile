FROM debian:latest  
  
# Install Supporting Packages  
RUN apt-get -q update && \  
apt-get install -qy --force-yes curl python && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get -q update && \  
apt-get install -qy --force-yes \  
build-essential \  
git \  
nodejs \  
libavahi-compat-libdnssd-dev && \  
apt-get install -qy --force-yes nodejs && \  
apt-get -q clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN npm install -g homebridge && \  
npm install -g homebridge-lifx && \  
mkdir -p /config  
  
COPY config.json /config/config.json  
COPY run.sh /run.sh  
  
RUN chmod +x /run.sh && mkdir -p /var/run/dbus  
  
VOLUME /config  
  
CMD ["/run.sh"]  

