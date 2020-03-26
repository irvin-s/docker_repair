FROM python:3.6-slim  
  
ENV DJANGO_VERSION 1.11.5  
  
RUN apt-get update && apt-get install -y \  
gcc \  
gettext \  
git \  
mysql-client \  
libmysqlclient-dev \  
postgresql-client \  
libpq-dev \  
libjpeg62 \  
libjpeg62-turbo-dev \  
netcat \  
supervisor \  
sqlite3 \  
\--no-install-recommends && rm -rf /var/lib/apt/lists/* \  
&& mkdir -p /var/www/app  
  
EXPOSE 8000  
  
WORKDIR /var/www/app  
  
RUN pip install django=="$DJANGO_VERSION" \  
gunicorn \  
psycopg2 \  
uwsgi  
  
CMD []  

