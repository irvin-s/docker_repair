FROM python:slim  
  
COPY . buzzbot/  
WORKDIR buzzbot  
  
RUN pip install -r requirements.txt  
  
EXPOSE 5000  
CMD ["python", "-u", "main.py"]

