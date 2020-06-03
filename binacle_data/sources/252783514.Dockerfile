FROM python:3  
WORKDIR /glouton  
  
# Install app dependencies  
COPY requirements.txt ./  
  
RUN pip install -r requirements.txt  
  
# Bundle app source  
COPY . .  
CMD "/bin/bash"  

