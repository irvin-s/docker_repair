FROM python:3-alpine  
MAINTAINER Simone <chaufnet@gmail.com>  
  
RUN pip install zerobin  
  
ENTRYPOINT ["zerobin"]  
CMD ["--host=0.0.0.0"]  

