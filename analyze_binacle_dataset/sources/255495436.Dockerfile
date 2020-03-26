FROM binhex/arch-base:latest
MAINTAINER binhex

# additional files
##################

# add supervisor conf file for app
ADD build/*.conf /etc/supervisor/conf.d/

# add setup bash script
ADD build/root/*.sh /root/

# add run bash script
ADD run/nobody/*.sh /home/nobody/

# add run bash script
ADD run/root/*.sh /root/

# add pre-configured config files for nobody
ADD config/nobody/ /home/nobody/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# expose port for http
EXPOSE 8050

# expose port for https
EXPOSE 8060

# set environment variables for user nobody
ENV HOME /home/nobody

# set permissions
#################

# run script to set uid, gid and permissions
CMD ["/bin/bash", "/root/init.sh"]