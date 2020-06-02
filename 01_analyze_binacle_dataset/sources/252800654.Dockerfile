FROM python:3.5  
WORKDIR /app  
  
ADD . /app  
  
RUN pip install --trusted-host pypi.python.org -r requirements.txt  
  
EXPOSE 80  
ENV NAME hw  
  
CMD ["python", "main.py"]

