FROM ubuntu:14.04  
RUN apt-get update -yq  
  
RUN apt-get install -y python-dev python-pip  
  
RUN pip install facebook-scribe  
  
RUN mkdir /fb303_scripts  
  
ADD __init__.py /fb303_scripts/  
  
ADD fb303_simple_mgmt.py /fb303_scripts/  
  
ADD ./scribe_ctrl /  
  
ENTRYPOINT ["/scribe_ctrl"]  

