FROM bradleybossard/docker-python-devbox  
  
RUN apt-get install -y pkg-config \  
libfreetype6-dev  
  
RUN pip install matplotlib  

