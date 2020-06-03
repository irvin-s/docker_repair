FROM python:2.7  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
RUN apt-get update \  
&& apt-get install -y \  
nginx supervisor \  
build-essential libxslt-dev libxml2-dev \  
ttf-dejavu ttf-freefont ttf-liberation \  
libpq-dev libpcre3-dev libffi-dev \  
gnupg git mercurial \  
netcat \  
&& pip install --src /usr/src --no-cache-dir uwsgi pipenv  
ADD wkhtmltopdf.tar.xz /bin/

