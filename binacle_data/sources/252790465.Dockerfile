FROM python:3.6-slim  
  
LABEL maintainer="careerlist"  
  
RUN apt-get update && apt-get install -y \  
git \  
ca-certificates \  
curl \  
# pycurl -> tuspy -> pyvimeo  
libgnutls28-dev \  
libcurl4-gnutls-dev \  
# ujson  
gcc \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip install --no-cache-dir \  
virtualenv \  
&& virtualenv env  
  
ENV APP_DIR /app  
  
RUN mkdir -p ${APP_DIR}  
  
WORKDIR ${APP_DIR}  

