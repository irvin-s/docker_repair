FROM python:3.5  
RUN pip install safety  
CMD ["safety", "check"]  
  

