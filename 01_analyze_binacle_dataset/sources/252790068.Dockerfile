FROM debian:stretch  
MAINTAINER Camptocamp  
  
ENV DEBIAN_FRONTEND=noninteractive \  
POSTFIX_HOSTNAME=odoo.postfix.local \  
ODOO_DB_NAME=odoodb \  
ODOO_HOST=odoo \  
ODOO_USER_ID=1 \  
ODOO_USER_PWD=admin \  
ODOO_MODEL=project.project  
  
RUN apt-get update \  
&& apt-get install -q -y --no-install-recommends \  
jq \  
rsyslog \  
postfix \  
python \  
# Only here for debug  
vim telnet procps  
  
VOLUME "/var/spool/postfix"  
  
EXPOSE 25  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
COPY openerp_mailgate.py /openerp_mailgate.py  
COPY test_mailgate.sh /test_mailgate.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
CMD ["tail", "-F", "/var/log/mail.log"]  

