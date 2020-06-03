FROM python:3.6  
EXPOSE 5000  
RUN pip3 install -U brewblox-service  
  
ENTRYPOINT ["python3", "-m", "brewblox_service"]  

