FROM continuumio/miniconda  
  
RUN conda config \--add channels conda-forge  
  
RUN conda install pocl pyopencl  
  

