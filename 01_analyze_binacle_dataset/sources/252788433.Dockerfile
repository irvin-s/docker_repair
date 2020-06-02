FROM python:2  
MAINTAINER James Bulmer <nekinie@gmail.com>  
  
RUN groupadd -r thumbor && useradd -m -g thumbor thumbor  
  
RUN \  
apt-get update && \  
apt-get -y install \  
libssl-dev \  
libcurl4-openssl-dev \  
python-numpy \  
python-opencv \  
libopencv-dev \  
libjpeg-dev \  
libpng-dev \  
libx264-dev \  
libass-dev \  
libvpx1 \  
libvpx-dev \  
libwebp-dev \  
webp \  
gifsicle && \  
pip install thumbor  
  
EXPOSE 8080  
  
USER thumbor  
CMD ["thumbor", "--port=8080"]  

