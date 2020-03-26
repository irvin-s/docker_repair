# Version 1.5  
FROM python:2.7  
MAINTAINER Allan Lei "allanlei@helveticode.com  
  
# Environment setup  
ENV HOME /usr/src/app  
ENV PWD /usr/src/app  
ENV LANG en_US.UTF-8  
ENV PYTHONUNBUFFERED True  
ENV PYTHONIOENCODING utf-8  
  
  
# Setup  
WORKDIR /usr/src/app  
RUN pip install --use-wheel bandersnatch==1.5  
RUN bandersnatch mirror || true  
  
CMD ["bandersnatch", "mirror"]

