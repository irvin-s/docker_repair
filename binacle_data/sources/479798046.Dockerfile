# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Adrian Moreno <adrian.moreno@emc.com>

# Update the sources list
RUN apt-get update

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip
RUN apt-get install -y build-essential git curl

# Copy the application folder inside the container
ADD . /app/mosaicme-cacher

# Get pip to download and install requirements:
RUN pip install -r /app/mosaicme-cacher/requirements.txt

# Set environment variables
ENV PYTHONPATH /app/mosaicme-cacher:$PYTHON_PATH

# Set the default directory where CMD will execute
WORKDIR /app/mosaicme-cacher

CMD python cacher.py
