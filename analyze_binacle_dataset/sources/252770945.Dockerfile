FROM fedora/apache:latest  
  
LABEL version="1.0"  
LABEL description="The backend of my Homeautomatizaion"  
  
EXPOSE 443  
# install packages  
RUN dnf -y update && dnf -y install \  
httpd \  
mod_ssl \  
mod_wsgi \  
python3 \  
python3-mod_wsgi \  
&& dnf clean all  
  
# fix httpd config  
RUN sed -i.orig 's/#ServerName/ServerName/' /etc/httpd/conf/httpd.conf  
  
WORKDIR /var/www/homeautomation  
  
# env var for further reference  
ENV REQ_FILE=requirements.txt  
  
# copy requirements file  
COPY ${REQ_FILE} /var/www/homeautomation  
RUN pip3 install -r ${REQ_FILE}  
  
COPY homeautomation_vhost.conf /etc/httpd/conf.d  
  
COPY . /var/www/homeautomation  
  
RUN chown -R apache:apache /var/www/homeautomation  
RUN chmod 774 /var/www/homeautomation  
RUN chmod 774 /var/www/homeautomation/app.sqlite  
  
# compile files  
# RUN python3 -m compileall .  
CMD ["/run-apache.sh"]  

