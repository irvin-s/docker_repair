FROM continuumio/miniconda  
  
# Install procps (to get free and top)  
RUN apt-get update --fix-missing && \  
apt-get install -y procps  
  
RUN conda install -y -c conda-forge -c bioconda numpy=1.13.3 cooler=0.7.6  
  
COPY *.sizes /annotation/

