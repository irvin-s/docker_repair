# Rebuilt lipcomputing/ipyrad  
FROM continuumio/miniconda  
MAINTAINER Andy Pohl <andy.pohl@wisc.edu>  
RUN conda install -c ipyrad ipyrad=0.6.0 \  
&& mkdir /scratch \  
&& chmod a+rwx /scratch  
WORKDIR /scratch  

