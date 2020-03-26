FROM python:3.6  
RUN pip install selenium requests pytest  
  
ENTRYPOINT [ "python", "-u" ]  

