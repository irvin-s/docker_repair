FROM nvidia/cuda:8.0-runtime-ubuntu16.04  
ADD nvidia-exporter /nvidia-exporter  
  
ENTRYPOINT /nvidia-exporter  

