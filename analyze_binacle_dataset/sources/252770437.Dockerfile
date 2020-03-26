FROM aexea/aexea-base-py2  
MAINTAINER Kakaru Team <https://github.com/asmaps/kakaru/graphs/contributors>  
  
RUN mkdir -p /opt/code  
WORKDIR /opt/code  
  
ADD requirements.txt /opt/code/requirements.txt  
RUN pip install -r requirements.txt  
  
ADD . /opt/code  
  
USER uid1000  
  
CMD ./start.sh  

