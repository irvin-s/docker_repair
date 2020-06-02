# Start with a Python image.  
FROM python:3.6-stretch  
MAINTAINER brian@linuxpenguins.xyz  
  
# Some stuff that everyone has been copy-pasting  
# since the dawn of time.  
ENV PYTHONUNBUFFERED 1  
# Install OS dependencies  
RUN apt-get update \  
&& apt-get install -y \  
sudo \  
libimage-exiftool-perl libav-tools exiftran \  
&& rm -rf /var/lib/apt/lists/*  
  
# Make application directory  
RUN mkdir -p /opt/spud /etc/spud  
WORKDIR /opt/spud  
  
# Install our requirements.  
ADD requirements/*.txt /opt/spud/requirements/  
RUN pip install -r requirements/docker.txt  
  
# Copy all our files into the image.  
COPY . /opt/spud/  
  
RUN find -type d -print0 | xargs -0 chmod 755 \  
&& find -type f -print0 | xargs -0 chmod 644 \  
&& find scripts -type f -name "*.sh" -print0 | xargs -0 chmod 755 \  
&& chmod 755 *.py \  
&& chmod 644 conftest.py  
  
# Specify the command to run when the image is run.  
EXPOSE 8000  
VOLUME '/etc/spud' '/var/lib/spud'  
CMD /opt/spud/scripts/docker.sh  

