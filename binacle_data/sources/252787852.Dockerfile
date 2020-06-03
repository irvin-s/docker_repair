FROM ubuntu:12.04  
MAINTAINER @cpswan  
  
# Add universe repository to /etc/apt/sources.list  
# we need it for nginx  
RUN sed -i s/main/'main universe'/ /etc/apt/sources.list  
  
# Add additional repo for HAproxy 1.5  
RUN apt-get update && apt-get install python-software-properties -y && \  
add-apt-repository ppa:vbernat/haproxy-1.5 && apt-get update  
  
# Install Nginx, HAproxy, OpenSSH, Supervisord etc.  
RUN apt-get install -y nginx haproxy supervisor \  
libapr1 libaprutil1 libcurl3 liblua5.1 wget vim rsyslog curl  
  
# Move packaged nginx out of the way  
RUN mv /usr/sbin/nginx /usr/sbin/nginx.orig  
  
# Add in nginx 1.6.3 binary with modsecurity 2.9.0 compiled in  
ADD nginx /usr/sbin/  
RUN chmod +x /usr/sbin/nginx  
  
# Remove the default Nginx configuration file  
RUN rm -v /etc/nginx/nginx.conf  
  
# Create empty directory for logs  
RUN mkdir -p /usr/share/nginx/logs/  
  
# Create log directory for supervisor  
RUN mkdir -p /var/log/supervisor  
  
# Copy configuration files from the current directory  
ADD ./nginx.conf /etc/nginx/  
ADD ./modsecurity.conf /etc/nginx/  
ADD ./unicode.mapping /etc/nginx/  
ADD ./ssl.key /etc/nginx/ssl/  
ADD ./ssl.crt /etc/nginx/ssl/  
ADD ./haproxy.cfg /etc/haproxy/  
ADD ./supervisord.conf /etc/supervisor/conf.d/  
  
# Install OWASP ruleset  
RUN cd /usr/src &&\  
wget https://github.com/SpiderLabs/owasp-modsecurity-crs/tarball/master \  
-O owasp.tar.gz &&\  
tar -xvf owasp.tar.gz &&\  
cd S* &&\  
cat modsecurity_crs_10_setup.conf.example >> /etc/nginx/modsecurity.conf &&\  
cat base_rules/*.conf >> /etc/nginx/modsecurity.conf &&\  
cp base_rules/*.data /etc/nginx/  
  
# Expose ports  
EXPOSE 22 80 443 4433  
# Set the default command to execute  
# when creating a new container  
CMD /usr/bin/supervisord  
  
# Example runline:  
# sudo docker run -d -p 2222:22 -p 80:80 -p 443:443 -p 4433:4433 \  
# cpswan/net-app-svcs  

