FROM ubuntu:16.04  
# Fixes issues with docker exec  
# See https://github.com/dockerfile/mariadb/issues/3  
RUN echo "export TERM=xterm" >> ~/.bashrc  
  
# Install deps  
RUN apt-get update -y \  
&& apt-get install -y curl \  
rsync \  
python-pip \  
awscli \  
mysql-client-5.7 \  
duplicity \  
&& pip install boto  
  
# Create directory for code  
COPY ./app /app  
WORKDIR /app  
  
# Permissions  
RUN chmod -R +x /app  
  
# Environment Defaults  
ENV DIRS_TO_BACKUP="/efs" \  
MYSQL_SERVICES="mysql" \  
MYSQL_USER="user" \  
MYSQL_PASSWORD="password" \  
MYSQL_DATABASE="data" \  
TMP_STORAGE="/tmp" \  
S3_BUCKET="" \  
STACK_NAME=""  
# Run the command on container startup  
ENTRYPOINT /app/entrypoint.sh

