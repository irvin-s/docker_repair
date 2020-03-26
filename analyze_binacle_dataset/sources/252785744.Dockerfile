FROM dit4c/dit4c-container-jupyter:latest  
MAINTAINER Tim Dettrick <t.dettrick@uq.edu.au>  
  
RUN pip3 install --upgrade jupyterlab && su - researcher -c \  
"jupyter serverextension enable --py jupyterlab"  
RUN rm -f /etc/supervisord.d/jupyter.conf  
  
ADD /etc /etc  
ADD /var /var  

