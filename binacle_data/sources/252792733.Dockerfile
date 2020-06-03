FROM python:3.6.3  
MAINTAINER Cherry Ng <cherry92@gmail.com>  
  
# Install tensorflow  
RUN pip install --upgrade \  
https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.4.0-cp36-cp36m-linux_x86_64.whl  
  
# Install dependencies  
RUN pip install --upgrade numpy  
RUN pip install --upgrade pandas  

