FROM python:3  
  
MAINTAINER david@codesmith.tech  
  
RUN curl -o pip.py https://bootstrap.pypa.io/get-pip.py && \  
python pip.py && \  
pip install \--upgrade pip && \  
pip install Flask Flask-SQLAlchemy  
  
WORKDIR /app  
  

