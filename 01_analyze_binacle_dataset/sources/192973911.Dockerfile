FROM phusion/baseimage:0.9.16

# Dependencies
RUN DEBIAN_FRONTEND='noninteractive' add-apt-repository ppa:nginx/stable && \
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'   &&\
  curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -  && \
  apt-get update && \
  DEBIAN_FRONTEND='noninteractive' apt-get -y --force-yes install wget \
  python-dev build-essential ncurses-dev software-properties-common \
  python-software-properties libpq-dev binutils gdal-bin libproj-dev \
  libgdal-dev python-gdal ncurses-dev postgresql-9.4-postgis-scripts \
  nginx-full git-core

# Due to an ubuntu bug (#1306991) we can't use the ubuntu provided pip package, so we're using
# the recommended way: http://pip.readthedocs.org/en/latest/installing.html#install-pip
RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python2.7

# APP_HOME, if you change this variable make sure you update the files in docker/ too
ENV APP_HOME /srv/postcodeinfo

RUN mkdir -p /var/log/gunicorn /var/log/nginx/postcodeinfo
RUN touch /var/log/gunicorn/access.log /var/log/gunicorn/error.log
RUN chown -R www-data:www-data /var/log/gunicorn && chmod -R g+s /var/log/gunicorn

# copy the nginx config
ADD ./docker/nginx.conf /etc/nginx/nginx.conf

# install service files for runit
ADD ./docker/nginx.service /etc/service/nginx/run
ADD ./docker/gunicorn.service /etc/service/gunicorn/run
ADD ./docker/syslog-format.conf /etc/syslog-ng/conf.d/001-format.conf

# create cache dir owned by the web server
RUN mkdir -p /var/cache/postcodeinfo && chown www-data /var/cache/postcodeinfo

# Define mountable directories.
VOLUME ["/var/log/nginx", "/var/log/gunicorn"]

# Add project directory to docker
WORKDIR ${APP_HOME}
ADD . ${APP_HOME}
RUN rm -rf ${APP_HOME}/.git
RUN chown -R www-data: ${APP_HOME}
RUN cd ${APP_HOME} && pip install -r requirements.txt
RUN ./manage.py collectstatic --noinput

# List of tunables (env vars) used by apps inside the container.
#ENV DJANGO_DEBUG true
#ENV DJANGO_ALLOWED_HOSTS 127.0.0.1
#ENV SECRET_KEY tfZmYFM7KWWbSujx2F4WZyYAIcUrQRZp
#ENV OS_FTP_USERNAME anonymous
#ENV OS_FTP_PASSWORD anonymous@
#ENV DB_NAME postcodeinfo
#ENV DB_USERNAME postcodeinfo
#ENV DB_PASSWORD postcodeinfo
#ENV DB_HOST postgres
#ENV DB_PORT 5432

EXPOSE 80

# Slim down the image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
