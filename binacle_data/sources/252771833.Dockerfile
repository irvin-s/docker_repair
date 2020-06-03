FROM ubuntu:16.04  
  
MAINTAINER Alexey Nurgaliev <atnurgaliev@gmail.com>  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y python python-pip python-ldap mercurial git locales \  
python-dev software-properties-common libmysqlclient-dev libpq-dev && \  
add-apt-repository -y ppa:nginx/stable && \  
apt-get update && \  
apt-get install -y nginx && \  
\  
mkdir /kallithea && \  
cd /kallithea && \  
mkdir -m 0777 config repos logs && \  
hg clone https://kallithea-scm.org/repos/kallithea -u stable && \  
cd kallithea && \  
rm -r .hg && \  
python -m pip install --upgrade --force pip && \  
pip install -e . && \  
python setup.py compile_catalog && \  
\  
pip install mysql-python && \  
pip install psycopg2 && \  
\  
apt-get purge --auto-remove -y python-dev software-properties-common && \  
\  
rm /etc/nginx/sites-enabled/*  
  
ADD kallithea_vhost /etc/nginx/sites-enabled/kallithea_vhost  
ADD run.sh /kallithea/run.sh  
  
VOLUME ["/kallithea/config", "/kallithea/repos", "/kallithea/logs"]  
  
EXPOSE 80  
  
CMD ["/kallithea/run.sh"]  

