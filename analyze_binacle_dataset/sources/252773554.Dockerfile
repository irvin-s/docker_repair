FROM debian:9  
MAINTAINER contact@algoo.fr  
  
ENV LANG C.UTF-8  
ENV LANGUAGE C.UTF-8  
ENV LC_ALL C.UTF-8  
# Install required packages  
RUN DEBIAN_FRONTEND=noninteractive apt update -q \  
&& DEBIAN_FRONTEND=noninteractive apt install -yq \  
git \  
realpath \  
redis-server \  
python3 \  
python3-dev \  
python3-pip \  
python-lxml \  
build-essential \  
libxml2-dev \  
libxslt1-dev \  
zlib1g-dev \  
libjpeg-dev \  
libpq-dev \  
libreoffice \  
uwsgi \  
curl \  
uwsgi-plugin-python3 \  
openjdk-8-jre-headless \  
libmagickwand-6.q16-3 \  
nginx \  
inkscape \  
mysql-client \  
postgresql-client \  
# Clone from GitHub  
&& git clone http://github.com/tracim/tracim.git \  
&& cd /tracim/ \  
&& git checkout master \  
# Install Node.js  
&& curl -sL https://deb.nodesource.com/setup_7.x | bash - \  
&& DEBIAN_FRONTEND=noninteractive apt install -yq nodejs \  
&& npm install \  
&& npm run gulp-dev \  
&& rm -rf /tracim/node_modules \  
# Install Tracim  
&& pip3 install -r install/requirements.txt \  
&& pip3 install -r install/requirements.mysql.txt \  
&& pip3 install -r install/requirements.postgresql.txt \  
&& cd /tracim/tracim \  
&& python3 setup.py develop \  
# Translation  
&& python3 setup.py compile_catalog \  
# Purges useless packages  
&& DEBIAN_FRONTEND=noninteractive apt purge -yq \  
curl \  
git \  
nodejs \  
python3-dev \  
build-essential \  
libxml2-dev \  
libxslt1-dev \  
zlib1g-dev \  
libjpeg-dev \  
libpq-dev \  
&& DEBIAN_FRONTEND=noninteractive apt autoremove -yq \  
&& DEBIAN_FRONTEND=noninteractive apt clean -q \  
&& rm -rf /var/lib/apt/list/*  
  
COPY uwsgi.ini /tracim/uwsgi.ini  
COPY nginx.conf /tracim/nginx.conf  
COPY check_env_vars.sh /tracim/check_env_vars.sh  
COPY common.sh /tracim/common.sh  
COPY entrypoint.sh /tracim/entrypoint.sh  
  
VOLUME ["/etc/tracim", "/var/tracim"]  
  
CMD ["/bin/bash","/tracim/entrypoint.sh"]  

