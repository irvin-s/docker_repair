################  
# Base Development file Development Docker File  
################  
FROM python:2-slim  
  
COPY requirements.txt requirements.txt  
  
RUN apt-get update && \  
apt-get install -y build-essential \  
libmysqlclient-dev \  
postgresql-server-dev-all \  
mysql-client \  
redis-tools \  
libxml2-dev \  
libxslt-dev \  
&& pip install --no-cache-dir -r requirements.txt \  
&& rm -rf $HOME/.cache \  
&& apt-get purge -y python.* \  
&& apt-get autoremove -y \  
&& apt-get clean  

