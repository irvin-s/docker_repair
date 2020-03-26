FROM tensorflow/tensorflow:latest-gpu  
MAINTAINER Andreas Fritzler <andreas.fritzler@gmail.com>  
  
RUN pip --no-cache-dir install keras  
  
RUN DEBIAN_FRONTEND=noninteractive \  
apt-get update && apt-get install -qq -y \  
git \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN git clone https://github.com/fchollet/keras.git /keras  
  
RUN rm /tensorflow_*  
  
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"  
  

