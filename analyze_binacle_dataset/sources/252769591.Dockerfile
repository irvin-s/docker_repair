FROM alpine:latest  
  
#MAINTAINER  
# data should be mounted with a directory container your PDF's  
RUN mkdir /data  
VOLUME ["/data"]  
  
RUN apk update  
RUN apk add \  
pdftk \  
ghostscript \  
imagemagick \  
ghostscript-fonts \  
python \  
python-dev \  
py-pip  
  
RUN pip install werkzeug executor gunicorn  
  
ADD app.py /app.py  
EXPOSE 80  
ENTRYPOINT ["/usr/bin/gunicorn"]  
  
# Show the extended help  
CMD ["-b", "0.0.0.0:80", "--log-file", "-", "app:application"]  

