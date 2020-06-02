FROM alpine:3.5  
LABEL maintainer "clement@le-corre.eu"  
LABEL description "Flask framwork for display info"  
  
ARG FLASK_VERSION=0.12.1  
RUN apk add --update --no-cache \  
python3 \  
py3-pip && \  
pip3 install --upgrade pip && \  
pip3 install Flask==${FLASK_VERSION}  
  
COPY www /var/www  
  
EXPOSE 5000  
CMD ["python3", "/var/www/app.py"]  

