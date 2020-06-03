# Special thanks to Tai Kersten who initially built this
# To run this image you need the following environment variables to be set
# ALLOWED_IPS: a bash list of ips that will be allowed to access the node

# Pull all binaries into a second stage deploy alpine container
FROM kunstmaan/ethereum-geth
RUN apt-get update

RUN apt-get install -y nginx
RUN apt-get install -y apache2-utils
RUN apt-get install -y python

RUN htpasswd -c /etc/nginx/protected.htpasswd demo
COPY protected.htpasswd demo
COPY ./default /etc/nginx/sites-available/default
COPY ./config_nginx.py /config_nginx.py

RUN apt-get update
RUN apt-get install -qq -y software-properties-common
RUN apt-get install -qq -y ca-certificates
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get -y install ufw
# RUN apt-get -y install python-certbot-nginx
# RUN certbot --nginx

EXPOSE 80 8545 8546 30303 30303/udp

ENTRYPOINT ["nginx", "-g", "daemon off;"]