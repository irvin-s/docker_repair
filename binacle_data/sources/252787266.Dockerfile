FROM brewblox/brewblox-service:latest  
  
RUN pip3 install -U brewblox-history  
  
ENTRYPOINT ["python3", "-m", "brewblox_history"]  

