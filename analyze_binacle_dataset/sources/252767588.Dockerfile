FROM python:3.6  
  
# Build args  
ARG REQUIREMENTS_FILE=/build/requirements/base.txt  
  
# Copy in your requirements folder  
ADD requirements /build/requirements/  
  
# Install dependencies  
RUN set -ex \  
&& apt-get update \  
&& apt-get install -y \  
postgresql-client \  
libpq-dev \  
\--no-install-recommends \  
&& rm -rf /var/lib/apt/lists/ \  
&& pip install --no-cache-dir -r $REQUIREMENTS_FILE  
# Copy your application code to the container  
RUN mkdir /code/  
WORKDIR /code  
ADD . /code  
  
# open public media folder  
RUN chmod 777 -Rf /code/public/media  
  
# Add any custom, static environment variables needed by Django:  
ENV PYTHONUNBUFFERED=1 \  
DJANGO_SETTINGS_MODULE=app.settings \  
SECRET_KEY='***** change me *****' \  
ALLOWED_HOSTS=* \  
RDS_HOSTNAME=db \  
RDS_PORT=5432 \  
RDS_DB_NAME=postgres \  
RDS_USERNAME=postgres \  
RDS_PASSWORD=password \  
RDS_ADMIN_HOSTNAME=db \  
RDS_ADMIN_PORT=5432 \  
RDS_ADMIN_DB_NAME=postgres \  
RDS_ADMIN_USERNAME=postgres \  
RDS_ADMIN_PASSWORD=password \  
EMAIL_HOST=mail \  
EMAIL_PORT=1025 \  
EMAIL_HOST_USER=user \  
EMAIL_HOST_PASSWORD=password  
  
# uWSGI configuration:  
ENV UWSGI_WSGI_FILE=app/wsgi.py \  
UWSGI_HTTP=:8000 \  
UWSGI_MASTER=1 \  
UWSGI_WORKERS=2 \  
UWSGI_THREADS=8 \  
UWSGI_UID=1000 \  
UWSGI_GID=2000 \  
UWSGI_LAZY_APPS=1 \  
UWSGI_WSGI_ENV_BEHAVIOR=holy  
  
# Docker entrypoint:  
ENV DJANGO_MANAGEPY_MIGRATE=on \  
DJANGO_MANAGEPY_COLLECTSTATIC=on \  
DJANGO_MANAGEPY_UPDATEINDEX=on  
  
# Expose port  
EXPOSE 8000  
  
ENTRYPOINT ["/code/docker-entrypoint.sh"]  
  
# Start uWSGI:  
CMD ["uwsgi", "--http-auto-chunked", "--http-keepalive"]

