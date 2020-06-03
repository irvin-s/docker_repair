FROM ubuntu:vivid

ENV DEBIAN_FRONTEND noninteractive

# Usual update / upgrade
RUN apt-get update && apt-get upgrade -q -y && apt-get dist-upgrade -q -y

# Let our containers upgrade themselves
RUN apt-get install -q -y unattended-upgrades

# Install usual tools
RUN apt-get install -q -y wget vim

# Install nginx
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu utopic main" | tee -a /etc/apt/sources.list.d/nginx.list
RUN apt-get update
RUN apt-get install -q -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Create self-signed certificate
RUN openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout /etc/ssl/private/kibana.key -out /etc/ssl/private/kibana.crt -subj /CN=kibana
RUN chmod 600 /etc/ssl/private/kibana.key

# Add configurations and htpasswd
ADD conf/kibana.conf /etc/nginx/sites-available/kibana.conf
RUN ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/10-kibana.conf
ADD conf/htpasswd /etc/nginx/htpasswd
RUN chown www-data:www-data /etc/nginx/htpasswd

EXPOSE 443

CMD ["nginx"]
