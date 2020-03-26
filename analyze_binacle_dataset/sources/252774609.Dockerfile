FROM grahamdumpleton/mod-wsgi-docker:python-3.4-onbuild  
RUN pip install -r requirements  
  
CMD [ "parser-test.wsgi" ]  

