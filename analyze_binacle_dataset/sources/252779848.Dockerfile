FROM python:stretch  
LABEL maintainer="JSenecal@connectitnet.com"  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
curl \  
gnupg  
  
COPY src/ /  
  
RUN curl https://repo.powerdns.com/FD380FBB-pub.asc | apt-key add - \  
&& apt-get update && apt-get install -y --no-install-recommends \  
pdns-recursor \  
&& apt-get purge -y --auto-remove curl gnupg \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip3 install envtpl \  
&& rm -rf ~/.cache/*  
  
ENV VERSION=4.1 \  
PDNS_setuid=pdns \  
PDNS_setgid=pdns \  
PDNS_daemon=no \  
PDNS_local_port=53 \  
PDNS_local_address=0.0.0.0 \  
PDNS_allow-from=0.0.0.0/0 \  
PDNS_webserver=yes \  
PDNS_webserver_address=0.0.0.0 \  
PDNS_api_readonly=yes  
  
EXPOSE 53 53/udp 8082  
COPY recursor.conf.jinja2 /etc/powerdns/  
COPY docker-cmd.sh /  
  
CMD [ "bash", "/docker-cmd.sh" ]

