#++++++++++++++++++++++++++++++++++++++  
# Estadisticas Docker container  
#++++++++++++++++++++++++++++++++++++++  
FROM ubuntu  
MAINTAINER oriol@calidae.com  
  
#Install basic packages  
RUN apt-get update  
RUN apt-get install -y freetds-bin \  
freetds-common \  
freetds-dev \  
libpq-dev \  
python-dev \  
libmysqlclient-dev \  
python-pip  
  
#Install PIP project requirements  
RUN pip install pip --upgrade  
  
RUN pip install xlwt \  
psycopg2 \  
simplejson \  
pymssql \  
cherrypy \  
sqlalchemy \  
pisa \  
mako \  
xhtml2pdf==0.0.5 \  
html5lib==1.0b3 \  
reportlab==2.7  
  
RUN mkdir /root/application  

