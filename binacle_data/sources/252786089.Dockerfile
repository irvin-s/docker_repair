FROM python:2  
RUN ["apt-get","-y","update"]  
RUN ["apt-get","install","-y","git"]  
RUN ["git","clone","https://github.com/dam90/archimage"]  
WORKDIR archimage  
RUN ["pip","install","--no-cache-dir","-r","requirements.txt"]  
WORKDIR django_archimage  
EXPOSE 8001  
ENTRYPOINT ["gunicorn","django_archimage.wsgi","-b",":8001"]  

