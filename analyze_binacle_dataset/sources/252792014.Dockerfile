FROM python:slim  
  
COPY . sparkmail/  
WORKDIR sparkmail  
  
RUN pip install -r requirements.txt  
  
EXPOSE 5000  
CMD ["python", "-u", "main.py"]

