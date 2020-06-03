# An image with Keras and Hyperas build on top of Tensorflow.  
FROM tensorflow/tensorflow  
  
LABEL maintainer="Centroida [https://centroida.ai] <info@centroida.ai>"  
# Setup for basic usage  
RUN apt-get update -y \  
&& apt-get install vim -y \  
&& apt-get install libhdf5-serial-dev -y \  
&& pip install keras  
  
# TensorBoard  
EXPOSE 6006  
  
# Jupyter  
EXPOSE 8888  

