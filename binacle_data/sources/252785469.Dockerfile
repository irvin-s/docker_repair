FROM sbrg/cobrame:master  
  
RUN pip install --no-cache-dir notebook==5.*  
  
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]

