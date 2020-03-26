FROM cocoon/droydrunner  
  
RUN mkdir /opt/iva  
WORKDIR /opt/iva  
  
# install dependencies (robotframework ... )  
ADD requirements.txt /opt/iva/  
RUN pip install -r /opt/iva/requirements.txt  
  
# install pyjenkins  
RUN pip install PyYAML  
RUN pip install git+https://bitbucket.org/cocoon_bitbucket/pyjenkins.git  
  
VOLUME /tests  
#VOLUME /jenkins  
ADD ./demo /tests/  
WORKDIR /tests  
  
CMD []  

