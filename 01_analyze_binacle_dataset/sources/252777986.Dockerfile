FROM prologic/autodock  
  
ENTRYPOINT ["autodock-hipache"]  
CMD []  
  
COPY requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt  
  
WORKDIR /app  
COPY . /app/  
RUN pip install .  

