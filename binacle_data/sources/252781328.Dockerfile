FROM python:2  
ADD pdfmagic.py /  
RUN pip install delegator.py web.py  
EXPOSE 8080  
CMD ["python", "./pdfmagic.py"]  

