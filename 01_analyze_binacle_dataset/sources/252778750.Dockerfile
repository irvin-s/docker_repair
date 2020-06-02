FROM ubuntu:16.04  
MAINTAINER Abdul Somat Budiaji "abdulbudiaji@gmail.com"  
RUN apt-get update && apt-get install -y \  
gcc g++ \  
python python-dev python-pip \  
gettext \  
mysql-client libmysqlclient-dev \  
sqlite3 \  
\--no-install-recommends  
  
RUN pip install --upgrade pip  
  
# setuptools required to install matplotlib  
RUN pip install setuptools==25.1.1  
  
# freetype and png is required by matplotlib  
RUN apt-get install -y \  
libpng12-dev libfreetype6-dev pkg-config \  
\--no-install-recommends  
  
# libxml and libxslt is required by newspaper  
RUN apt-get install -y \  
libxml2-dev libxslt1-dev \  
\--no-install-recommends  
  
# required by gdal  
RUN apt-get install -y \  
libgdal-dev  
  
RUN pip install numpy==1.11.0 #whl  
RUN pip install scipy==0.17.1 #whl  
RUN pip install matplotlib==1.5.1 #source  
RUN pip install nltk==2.0.5 #source  
RUN pip install newspaper==0.0.9.8 #source  
  
# install gdal python binding  
ENV CPLUS_INCLUDE_PATH /usr/include/gdal  
ENV C_INCLUDE_PATH /usr/include/gdal  
RUN pip install GDAL==1.11.2 #source  
  
# install some tools  
RUN pip install beanstalkc==0.4.0 #whl  
RUN pip install googlemaps==2.4.3 #whl  
RUN pip install sendgrid==3.0.0 #whl  
RUN pip install nose==1.3.7 #whl  
RUN pip install path.py==8.2.1 #whl  
RUN pip install xlrd==1.0.0 #source  
RUN pip install xlwt==1.1.2 #whl  
RUN pip install schedule==0.3.2 #source  
RUN pip install itsdangerous==0.24 #source  
RUN pip install psutil==4.3.0 #source  
RUN pip install pika==0.10.0 #whl  
RUN pip install minio==2.0.0 #whl  
  
# install cython  
RUN pip install Cython==0.24.1 #whl  
  
# related to django web development  
RUN pip install mysqlclient==1.3.7 #source  
RUN pip install Django==1.9.7 #whl  
RUN pip install djangorestframework==3.4.0 # whl  
RUN pip install drfdocs==0.0.11 #source  
RUN pip install whitenoise==3.2 #whl  
RUN pip install Markdown==2.6.6 #source  
RUN pip install gunicorn==19.6.0 #whl  
RUN pip install luigi==2.2.0 #source  
RUN pip install cassandra-driver==3.5.0 #source  
RUN pip install reportlab==3.3.0 #source  
  
# install supervisor  
RUN pip install supervisor==3.3.0 #source  
  
# install frequently used locale  
RUN locale-gen id_ID.utf8  
RUN locale-gen en_US.utf8  
RUN update-locale  
  
# clean up  
RUN rm -rf /root/.cache/pip  
RUN rm -rf /var/lib/apt/lists/*  

