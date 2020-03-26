FROM python:3  
MAINTAINER Ajeeth Samuel <ajeeth.samuel@gmail.com>  
  
# Install dependencies  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
sudo graphviz postgresql-client libldap2-dev libsasl2-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Clone and install netbox  
ENV NETBOX_COMMIT 328958876aae64fd970605704aaaa79af61de1d6  
RUN mkdir -p /usr/src/netbox \  
&& git clone https://github.com/digitalocean/netbox.git /usr/src/netbox \  
&& (cd /usr/src/netbox && git checkout -q "$NETBOX_COMMIT") \  
&& (cd /usr/src/netbox && pip3 install --no-cache-dir -r requirements.txt)  
  
RUN pip3 install gunicorn \  
&& pip3 install django-auth-ldap  
  
# Change workdir  
WORKDIR /usr/src/netbox/netbox  
  
# Create user  
RUN groupadd -g 1000 netbox \  
&& useradd -u 1000 -g 1000 -d /usr/src/netbox netbox \  
&& chown -Rh netbox:netbox /usr/src/netbox  
  
# Setup entrypoint  
COPY entrypoint.sh /sbin/entrypoint.sh  
RUN chmod 755 /sbin/entrypoint.sh  
  
# Expose ports  
EXPOSE 8000/tcp  
  
ENTRYPOINT ["/sbin/entrypoint.sh"]  
CMD ["runserver", "--insecure", "0.0.0.0:8000"]  

