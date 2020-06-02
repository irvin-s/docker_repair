FROM python:3  
ENV PYTHONUNBUFFERED 1  
EXPOSE 3031 8000  
RUN useradd -ms /bin/bash app &&\  
mkdir -p /srv/app  
  
COPY requirements.txt /srv/app/  
RUN pip install --no-cache-dir \  
-r /srv/app/requirements.txt  
  
COPY . /srv/app  
  
WORKDIR /srv/app  
USER app  

