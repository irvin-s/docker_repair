FROM python:2  
MAINTAINER bagricola@squiz.co.uk  
  
RUN pip install yamllint ansible-lint ansible-review  

