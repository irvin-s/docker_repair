# Creates a container to update a public IP address  
# of an a-record managed by GoDaddy.  
# All parameters are passed via env vars  
# Env var examples:  
# GODADDY_KEY=<ACCESS KEY HERE>  
# GODADDY_SECRET=<SECRET KEY HERE>  
# GODADDY_DOMAIN_LIST=mydomain.org,myotherdomain.org  
# GODADDY_A_RECORD_LIST=updatertest,updatertest2  
FROM python  
  
MAINTAINER Wes Parish version: 0.2.0  
ADD GoDaddyUpdater.py /usr/bin/GoDaddyUpdater.py  
  
RUN pip install requests  
RUN pip install godaddypy  
RUN pip install pif  
  
CMD while /bin/true; do /usr/bin/GoDaddyUpdater.py; /bin/sleep 60; done  
  

