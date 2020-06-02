FROM huangwc/django:latest  
MAINTAINER huangwc@easecloud.cn  
  
WORKDIR /var/app  
  
ADD ./* ./  
  
RUN chmod +x build.sh && ./build.sh  
  
CMD ["gunicorn", "-b0.0.0.0:8000", "-w4", "-keventlet", "ecerp.wsgi"]

