FROM jupyter/datascience-notebook  
MAINTAINER Carl Boettiger cboettig@ropensci.org  
  
# RUN pip install datascience  
## pip release is out-of-date, install manually  
RUN pip install numexpr && \  
cd && git clone https://github.com/dsten/datascience && \  
cd datascience && make install  
  
VOLUME /home/jovyan/work  
  
CMD start-notebook.sh  

