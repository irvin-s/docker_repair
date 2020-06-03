FROM python:3.6-slim  
  
# From https://hub.docker.com/r/jamesanglin/numpy-scipy/  
RUN apt-get update &&\  
apt-get install -y \  
libblas-dev \  
liblapack-dev \  
liblapacke-dev \  
gfortran \  
libsdl-dev \  
libsdl-image1.2-dev \  
libsdl-mixer1.2-dev \  
libsdl-ttf2.0-dev \  
libsmpeg-dev \  
libportmidi-dev \  
libavformat-dev \  
libswscale-dev \  
libjpeg-dev \  
libfreetype6-dev \  
libsdl-image1.2-dev \  
libsdl-mixer1.2-dev \  
libsdl-ttf2.0-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD requirements.txt /requirements.txt  
  
RUN pip install -r requirements.txt  
  
ADD app /app  

