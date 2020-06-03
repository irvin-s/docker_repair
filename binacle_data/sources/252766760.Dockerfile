FROM alaindomissy/docker-miniconda2  
MAINTAINER Alain Domissy alaindomissy@gmail.com  
  
RUN conda install -y six  
  
COPY . /basespaceapp  
WORKDIR /basespaceapp  
RUN python setup.py install  
  
CMD python -m basespaceapp.app ./tests/data/  

