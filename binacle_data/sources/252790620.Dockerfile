FROM python:3.6-alpine  
  
ENV PYTHONUNBUFFERED 1  
EXPOSE 3031 8000  
RUN adduser -D app &&\  
mkdir -p /srv/app  
  
RUN apk add --no-cache gcc g++ python3-dev musl-dev linux-headers  
  
COPY requirements.txt /srv/app/  
RUN pip install --no-cache-dir \  
-r /srv/app/requirements.txt  
  
COPY . /srv/app  
  
WORKDIR /srv/app  
USER app  

