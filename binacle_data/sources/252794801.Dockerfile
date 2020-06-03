FROM davask/d-apache-openssl:2.4-d8.8  
MAINTAINER davask <docker@davaskweblimited.com>  
USER root  
LABEL dwl.server.certificat="letsencrypt"  
  
# declare letsencrypt  
ENV DWL_CERTBOT_EMAIL docker@davaskweblimited.com  
ENV DWL_CERTBOT_DEBUG false  
  
# install certbot  
RUN wget https://dl.eff.org/certbot-auto; \  
mv certbot-auto /usr/local/bin; \  
chmod a+x /usr/local/bin/certbot-auto; \  
certbot-auto --noninteractive --os-packages-only; \  
mkdir -p /etc/lestencrypt/live  
  
RUN apt-get upgrade -y && \  
apt-get autoremove -y && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY ./build/dwl/certbot.sh \  
./build/dwl/renew-certbot.sh \  
./build/dwl/virtualhost-tsl.sh \  
./build/dwl/init.sh \  
/dwl/  
  
RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl  
USER admin  

