# DOCKER-VERSION 0.4.0

FROM		 ubuntu:12.04
MAINTAINER	 Andrew Hodgson <andrew@ratiopartners.com>

# Install dependencies
RUN		 echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
RUN		 apt-get update -y
RUN		 apt-get install -y -qq git nginx-full

# Install kibana
RUN		 mkdir /src
RUN		 git clone https://github.com/elasticsearch/kibana.git /src/kibana

# Add config
ADD		 ./nginx.conf /etc/nginx/nginx.conf
ADD		 ./start-kibana.sh /src/start-kibana.sh

# Nginx port
EXPOSE		 :8080

CMD		 ["sh", "-ex", "/src/start-kibana.sh"]

# vim:ts=8:noet:
