FROM python:2-onbuild  
MAINTAINER Ted Chen <tedlchen@gmail.com>  
  
ENTRYPOINT ["python", "/usr/src/app/server.py"]  
CMD ["80"]  

