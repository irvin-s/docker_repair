FROM python:3.6.3-slim-stretch AS build  
  
ARG TARGET=prod  
  
ENV PYTHONUNBUFFERED=1 \  
PIP_REQUIRE_VIRTUALENV=false \  
WHEELS_PLATFORM=aldryn-baseproject-v4-py36 \  
PIPSI_HOME=/root/.pipsi/venvs \  
PIPSI_BIN_DIR=/root/.pipsi/bin \  
PATH=/virtualenv/bin:/root/.pipsi/bin:$PATH \  
PROCFILE_PATH=/app/Procfile \  
LC_ALL=C.UTF-8 \  
LANG=C.UTF-8 \  
NVM_DIR=/opt/nvm \  
NVM_VERSION=0.33.5  
  
COPY stack /stack/base  
RUN DEBIAN_FRONTEND=noninteractive /stack/base/install.sh  
  
RUN virtualenv --no-site-packages /virtualenv  
  
RUN mkdir -p /app && mkdir -p /data  
  
  
FROM scratch  
COPY \--from=build / /  
  
# Execution environment setup  
# TODO: Remove NGINX_CONF_PATH once aldryn-django has been fixed to work  
# without it set.  
ENV PYTHONUNBUFFERED=1 \  
PIP_REQUIRE_VIRTUALENV=false \  
WHEELS_PLATFORM=aldryn-baseproject-v4-py36 \  
PIPSI_HOME=/root/.pipsi/venvs \  
PIPSI_BIN_DIR=/root/.pipsi/bin \  
PATH=/virtualenv/bin:/root/.pipsi/bin:$PATH \  
PROCFILE_PATH=/app/Procfile \  
LC_ALL=C.UTF-8 \  
LANG=C.UTF-8 \  
NVM_DIR=/opt/nvm \  
NVM_VERSION=0.33.5 \  
NGINX_CONF_PATH=""  
WORKDIR /app  
VOLUME /data  
EXPOSE 80/tcp 443/tcp  
  
ENTRYPOINT ["/tini", "-g", "--"]  
  
ADD Procfile /app/Procfile  
CMD ["start", "web"]  

