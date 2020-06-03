FROM	ubuntu:14.04

# Update the container
RUN	apt-get update \
	&& apt-get -y install nodejs npm supervisor nginx unattended-upgrades \
	&& unattended-upgrades

# Copy code and configuration to container
COPY 	infra/ /home/ubuntu/infra
COPY    code /home/ubuntu/code

# Install app dependencies and place resources in the required locations
RUN	ln -s "$(which nodejs)" /usr/bin/node \
	&& cp /home/ubuntu/infra/supervisord.conf /etc/supervisor/supervisord.conf \
        && cp /home/ubuntu/infra/nginx.conf /etc/nginx/nginx.conf \
	&& cd /home/ubuntu/code/; npm install \
	&& cp -R /home/ubuntu/infra/supervisor/* /etc/supervisor/conf.d/

EXPOSE  80
CMD 	["/usr/bin/supervisord"]
