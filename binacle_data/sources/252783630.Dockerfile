FROM node  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
  
RUN yarn && \  
yarn global add grunt-cli && \  
grunt build  
  
FROM python:3.4-slim  
ENV DJANGO_VERSION 1.9  
COPY requirements /usr/src/app/requirements  
COPY \--from=0 /usr/src/app /usr/src/app  
WORKDIR /usr/src/app  
  
RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7 && \  
apt-get update && \  
apt-get install -y \  
gcc \  
gettext \  
mysql-client libmysqlclient-dev \  
postgresql-client libpq-dev \  
sqlite3 \  
bzip2 \  
fontconfig \  
libfreetype6-dev \  
\--no-install-recommends && \  
rm -rf /var/lib/apt/lists/* && \  
pip install mysqlclient psycopg2 django=="$DJANGO_VERSION" && \  
mkdir -p /usr/src/app && \  
pip install --no-cache-dir -r requirements/dev.txt  
  
RUN python manage.py migrate  
  
EXPOSE 8000  
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]  

