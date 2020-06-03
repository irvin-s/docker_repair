FROM tensorflow/tensorflow:1.3.0-gpu-py3  
ADD . /DoomPCGML  
WORKDIR /DoomPCGML  
RUN apt-get update  
RUN apt-get install -y nano  
RUN pip install -r requirements.txt  
# Exposing port 6006 to host for tensorboard  
EXPOSE 6006  

