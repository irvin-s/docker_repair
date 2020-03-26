FROM python:latest  
RUN apt-get update  
RUN apt-get install -y apache2 libapache2-mod-wsgi-py3 python3-pip  
  
RUN python3.4 -m pip install django pymysql pillow  
  
WORKDIR /opt  
RUN mkdir isogen  
COPY . isogen/  
  
VOLUME /opt/isogen  
WORKDIR /etc/apache2/sites-enabled  
RUN pwd  
RUN rm -f *  
COPY isogen.conf .  
  
EXPOSE 80  
EXPOSE 3306  
ENTRYPOINT bash -c "service apache2 restart; bash"  
  

