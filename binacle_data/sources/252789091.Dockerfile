FROM dsdgroup/jupyter:gpu-cuda-8.0  
MAINTAINER Guo Quan <guoquanscu@gmail.com>  
  
ENV REFRESHED_AT 2017-08-02  
# install requirement packages  
RUN apt-get update && apt-get install -y libcupti-dev  
  
# install  
RUN pip install tensorflow-gpu  
  
# add one additional port for TensorBoard  
EXPOSE 6006  

