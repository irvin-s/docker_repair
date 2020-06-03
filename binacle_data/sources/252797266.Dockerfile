FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get install -y postgresql postgresql-contrib sudo \  
postgresql-common libpq-dev python-dev \  
libffi-dev libxml2-dev libxslt1-dev libcairo2 libpango1.0-0 \  
libgdk-pixbuf2.0-0 postgresql-client-9.5 make g++ git \  
libgraphicsmagick1-dev imagemagick libmagick++-dev \  
libgirepository1.0-dev python-cairo-dev postgresql-server-dev-9.5 \  
postgresql-9.5 redis-server python-pip language-pack-en && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
ADD requirements /requirements  
RUN pip install -r /requirements/development.txt && \  
pip install -r /requirements/testing.txt && \  
rm -rf /root/.cache/pip  

