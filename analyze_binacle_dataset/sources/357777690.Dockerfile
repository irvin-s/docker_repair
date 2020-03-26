FROM phusion/baseimage

RUN apt-get update && apt-get install -y \
	curl \
	python \
	make \
	g++
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get update && apt-get install -y \
	nodejs

RUN npm install pm2 -g

VOLUME ["/var/www/example.com/api"]
ADD start.sh /start.sh
RUN chmod 755 /start.sh
CMD ["/start.sh"]
