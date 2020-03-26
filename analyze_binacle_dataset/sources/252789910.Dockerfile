FROM ipython/scipyserver  
  
MAINTAINER Calvin Giles <calvin.giles@gmail.com>  
  
# Create install folder  
RUN mkdir /install_files  
  
# install python requirements  
COPY requirements.txt /install_files/requirements.txt  
RUN pip2 install -r /install_files/requirements.txt  
RUN pip3 install -r /install_files/requirements.txt  

