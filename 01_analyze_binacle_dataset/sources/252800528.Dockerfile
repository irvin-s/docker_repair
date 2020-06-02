FROM ubuntu  
RUN apt-get update  
RUN apt-get install -yq python-pip  
RUN pip install numpy six cython  
RUN pip install auto-sklearn  
RUN pip install jupyter  
  
CMD ["bash"]  

