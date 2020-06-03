FROM debian:stretch
LABEL maintainer="Nilton OS <jniltinho@gmail.com>"

## docker build -t debian-samba4 .
## docker run -it debian-samba4 /bin/bash
## docker run -it -p 443:443 jniltinho/debian-samba4 /bin/bash
## docker run -d --restart=unless-stopped -p 443:443 debian-samba4
## docker run -d --restart=unless-stopped -p 443:443 jniltinho/debian-samba4
## https://github.com/titpetric/netdata/blob/master/releases/latest/Dockerfile

## docker tag debian-samba4 jniltinho/debian-samba4
## docker push jniltinho/debian-samba4

# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
# docker rmi -f $(docker images -q)

ADD scripts/build.sh /build.sh
ADD scripts/run.sh /run.sh
ADD scripts/samba-4.9.0+dfsg-1.amd64.deb /tmp/

## Install base packages
RUN chmod +x /run.sh /build.sh && sync && sleep 1 && /build.sh

ADD scripts/nginx/default /etc/nginx/sites-available/default

EXPOSE 443
# EXPOSE 443 80 8088 19999
ENTRYPOINT ["/run.sh"]