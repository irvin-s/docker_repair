FROM python:2.7  
RUN git clone https://github.com/loris-imageserver/loris.git && \  
apt-get update && \  
apt-get install -y libjpeg-dev libfreetype6-dev zlib1g-dev \  
liblcms2-dev liblcms2-utils libtiff5-dev python-dev libwebp-dev apache2 \  
libapache2-mod-wsgi && \  
pip install Pillow uwsgi  
WORKDIR loris  
RUN pip install -r requirements.txt  
RUN python setup.py install --loris-owner=root --loris-group=root  
COPY entrypoint.sh /entrypoint.sh  
CMD ["sh", "/entrypoint.sh"]  

