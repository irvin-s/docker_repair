FROM python:alpine3.6  
WORKDIR /usr/src/app  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
COPY vault-unseal.py ./  
CMD [ "python", "./vault-unseal.py" ]  

