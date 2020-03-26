FROM tensorflow/tensorflow:latest  
  
MAINTAINER Alexander Tong <alexanderytong@gmail.com>  
  
COPY classify_image.py /root/classify_image.py  
  
COPY model /tmp/imagenet  

