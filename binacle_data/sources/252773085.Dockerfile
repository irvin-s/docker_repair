FROM python:3-alpine  
  
LABEL maintainer="b.eyselein@gmail.com"  
  
ARG WorkDir=/data  
  
ENV PYTHONPATH $WorkDir:$PYTHONPATH  
  
ADD main.py $WorkDir/main.py  
  
WORKDIR $WorkDir  
  
ENTRYPOINT timeout -t 2 -s KILL python main.py  

