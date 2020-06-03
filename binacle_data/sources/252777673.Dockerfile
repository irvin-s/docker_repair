FROM tensorflow/tensorflow:1.3.0-py3  
  
LABEL maintainer="Shunsuke GOTOH <antimon2.me@gmail.com>"  
  
RUN pip3 --no-cache-dir install --upgrade tensorflow-tensorboard  
  
CMD ["/bin/bash"]  

