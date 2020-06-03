FROM kaixhin/cuda-torch:7.0  
MAINTAINER Traun Leyden "traun.leyden@gmail.com"  
RUN apt-get install -y wget libpng-dev libprotobuf-dev protobuf-compiler  
RUN git clone \--depth 1 https://github.com/jcjohnson/neural-style.git  
RUN /root/torch/install/bin/luarocks install loadcaffe  
RUN chmod +x /root/torch/neural-style/models/download_models.sh  
RUN /root/torch/neural-style/models/download_models.sh  
  
RUN git clone https://gist.github.com/67939ced008b96e7aa43.git /root/devices  
  
WORKDIR /root/torch/neural-style  
VOLUME /root/torch/neural-style/models  
VOLUME /root/torch/neural-style/images  
VOLUME /root/torch/neural-style/outputs  

