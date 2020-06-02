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
  
RUN pip install CherryPy==3.2.3 \  
Mako==1.0.0 \  
MarkupSafe==0.23 \  
MySQL-python==1.2.5 \  
Pillow==2.6.1 \  
PyPDF2==1.23 \  
SQLAlchemy==0.9.8 \  
argparse==1.2.1 \  
html5lib==0.999 \  
psycopg2==2.5.4 \  
pymssql==2.1.1 \  
python-dateutil==2.2 \  
reportlab==3.1.8 \  
simplejson==3.6.5 \  
six==1.8.0 \  
wsgiref==0.1.2 \  
xhtml2pdf==0.0.6 \  
xlrd==0.9.3 \  
xlwt==0.7.5  
  
RUN mkdir /root/application  

