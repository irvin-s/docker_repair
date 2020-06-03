# Version: 1.0.0  
FROM brockresearch/python:3.6.1  
MAINTAINER Brock Research  
  
# Add Virtual Environment to enable project-specific package installations.  
RUN pip3 install virtualenv==15.1.0  
  
# Common Tools  
## TDD Framework  
RUN pip3 install pytest==3.2.1  
  
## Continuous pytest runner  
RUN pip3 install pytest-watch==4.1.0  
  
## BDD Framework  
RUN pip3 install behave==1.2.5  
  
## Project Scaffolding  
RUN pip3 install pyscaffold==2.5.7  
  
## Command Line Framework  
RUN pip3 install click==6.7  
  
## Web Framework  
RUN pip3 install flask==0.12.2  
  
## YAML Library  
RUN pip3 install pyyaml==3.12  
  
## Library to read and write Excel 2010 xlsx/xlsm files  
RUN pip3 install openpyxl==2.4.8  
  
## Library for pulling data out of HTML and XML files  
RUN pip3 install beautifulsoup4==4.6.0  
  
## Mongodb Driver  
RUN pip3 install pymongo==3.6.0  
  
## Diff JSON and JSON-like structures in Python.  
## https://github.com/ZoomerAnalytics/jsondiff  
RUN pip3 install jsondiff==1.1.1  
  
# Create projects directory under developer's home directory  
WORKDIR /root  
RUN mkdir -p /root/projects  
  
# Setup VIM Python syntax highlighting  
COPY vimrc /root/.vimrc  
  
CMD ["/bin/sh"]

