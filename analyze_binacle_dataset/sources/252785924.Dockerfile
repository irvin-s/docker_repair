FROM python:3-onbuild  
MAINTAINER Julien Tanay <julien.tanay@gmail.com>  
  
CMD ["--help"]  
  
ENTRYPOINT ["python", "/usr/src/app/whydtogo/__init__.py"]  

