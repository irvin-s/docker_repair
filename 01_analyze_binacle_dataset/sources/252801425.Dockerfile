FROM library/python:alpine  
ADD . /app  
CMD ["python", "/app/unity_nunit_printer.py"]

