FROM python:2  
WORKDIR /usr/src/app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
ADD backend ./  
  
CMD [ "python", "./app-checker.py" ]

