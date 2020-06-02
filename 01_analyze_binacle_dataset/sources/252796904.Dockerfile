FROM python:2  
WORKDIR scaling/pdfmagic  
  
RUN pip install delegator.py  
RUN pip install web.py  
  
EXPOSE 8080  
CMD ["python", "scaling/pdfmagic/pdfmagic.py"]  

