FROM ubuntu:14.04.1  
MAINTAINER C Camp  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get -y install make gcc dnsutils git curl zlib1g-dev build-essential \  
libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \  
libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common \  
python3-yaml  
  
RUN mkdir /pocketmine  
RUN cd /pocketmine && curl -sL http://get.pocketmine.net/ | bash -s - -r  
  
VOLUME /pocketmine  
WORKDIR /pocketmine  
  
EXPOSE 19132  
CMD ["./start.sh", "--no-wizard", "--enable-rcon=on"]  

