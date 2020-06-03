FROM python:3  
RUN mkdir -p /app  
  
WORKDIR /app/  
ENTRYPOINT python3 -m intro_offline_server  
  
ADD requirements.txt ./  
ADD LICENSE.txt ./  
  
RUN pip3 install -r requirements.txt  
  
ENV PYTHONUNBUFFERED=1  
RUN useradd -M -d /app app  
USER app  
  
ADD servers.txt ./  
ADD intro_offline_server.py ./  

