FROM alantrrs/caffe-fast-rcnn  
MAINTAINER Alan Torres <@alantrrs>  
  
# Extras  
RUN sudo apt-get install -y vim  
  
# Adds py-faster-rcnn  
ADD . /home/py-faster-rcnn  
WORKDIR /home/py-faster-rcnn  
RUN cd lib && make  
  
CMD ["bash"]  

