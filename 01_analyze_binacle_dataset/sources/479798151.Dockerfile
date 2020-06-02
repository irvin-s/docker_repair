# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Adrian Moreno <adrian.moreno@emc.com>

# Update the sources list
RUN apt-get update

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip
RUN apt-get install -y build-essential git curl
RUN apt-get install -y nginx gunicorn

# Copy the application folder inside the container
ADD . /app/mosaicme-web

# Get pip to download and install requirements:
RUN pip install -r /app/mosaicme-web/requirements.txt

# Set environment variables
ENV PYTHONPATH /app/mosaicme-web:$PYTHON_PATH

# setup all the config files
run rm /etc/nginx/sites-enabled/default
run ln -s /app/mosaicme-web/mosaicme_nginx.conf /etc/nginx/sites-enabled/mosaicme

# Set the default directory where CMD will execute
WORKDIR /app/mosaicme-web

# Expose ports
EXPOSE 80

CMD sh start.sh
