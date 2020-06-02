FROM divvycloud/base  
MAINTAINER DivvyCloud  
RUN sudo python --version  
RUN sudo easy_install -i http://release.divvycloud.com mysql-connector-python  
RUN sudo easy_install -i http://packages.divvycloud.com/simple divvycloud  
RUN mkdir config/  
RUN sudo easy_install pudb  
COPY config/divvy.tmpl config/divvy.tmpl  
COPY config/divvy.json config/divvy.json  
COPY scripts/entrypoint.py entrypoint.py  
COPY scripts/wait-for-it.sh wait-for-it.sh  
RUN chmod +x /entrypoint.py  
RUN chmod +x /wait-for-it.sh  
RUN sudo easy_install python-saml  
  

