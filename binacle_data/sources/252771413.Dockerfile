FROM python:3-onbuild  
RUN apt-get update  
RUN apt-get install -y vim  
RUN curl http://j.mp/spf13-vim3 -L -o - | sh  
RUN apt-get install -y python-setuptools  
RUN pip3 install asciinema  
  
VOLUME /home/ajn/Dropbox/coding/tmp  

