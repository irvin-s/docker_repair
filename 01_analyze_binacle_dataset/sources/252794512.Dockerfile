FROM ubuntu:14.04  
RUN apt-get -q -y update && apt-get -q -y install \  
ruby \  
python-virtualenv \  
python-setuptools \  
git \  
python-dev \  
ruby-dev \  
postgresql-client \  
bison \  
apache2 \  
libapache2-mod-wsgi \  
python-pip \  
python-psycopg2 \  
libgeos-c1 \  
libxml2-dev \  
libxslt1-dev \  
lib32z1-dev  
  
ENV PYCSW_HOME /usr/lib/pycsw  
ENV PYCSW_CONFIG /etc/pycsw  
ENV PYCSW_VERSION ckan  
  
# Create directories & virtual env for PYCSW  
RUN virtualenv $PYCSW_HOME \--system-site-packages  
RUN mkdir -p $PYCSW_CONFIG $PYCSW_HOME/src  
  
WORKDIR $PYCSW_HOME/src  
  
RUN git clone -b $PYCSW_VERSION https://github.com/GSA/pycsw #1  
RUN cd pycsw && \  
../../bin/python setup.py build && \  
../../bin/python setup.py install && \  
../../bin/pip install -r requirements.txt  
  
RUN rm -f /etc/apache2/sites-enabled/000-default.conf  
  
ADD files/pycsw.conf /etc/apache2/sites-enabled  
ADD files/pycsw-all.cfg $PYCSW_CONFIG  
ADD files/pycsw-collection.cfg $PYCSW_CONFIG  
ADD files/pycsw.wsgi $PYCSW_CONFIG  
ADD files/pycsw_config.sh /usr/local/bin  
ADD files/entrypoint.sh /entrypoint.sh  
  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
  
EXPOSE 80  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*  

