FROM continuumio/miniconda3  
  
MAINTAINER Chris Mutel <cmutel@gmail.com>  
  
RUN conda install -q -y -c anaconda redis  
RUN conda install -q -y -c conda-forge -c cmutel pandarus_remote  
RUN conda install -y -c conda-forge psutil iowait tornado pyzmq  
RUN pip install circus  
  
RUN mkdir /pr  
COPY circus.ini /pr/  
  
ENV PANDARUS_CPUS 4  
CMD ["circusd", "/pr/circus.ini"]  

