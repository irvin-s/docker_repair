  
FROM binstar/build-base:centos6  
  
MAINTAINER Sean Ross-Ross <srossross@gmail.com>  
  
RUN useradd binstar  
  
RUN chown binstar:binstar -R /opt/miniconda  
  
USER binstar  
WORKDIR /home/binstar  
  
ENV HOME /home/binstar  
ENV PATH /opt/miniconda/bin:$PATH  
RUN conda config \--set always_yes true && \  
conda config \--set binstar_upload false && \  
conda config \--add channels binstar  
RUN conda install conda-build jinja2 binstar psutil binstar-build llvm gcc  
RUN binstar config \--set sites.binstar.url "https://api.anaconda.org"  

