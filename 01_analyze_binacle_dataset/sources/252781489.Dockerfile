FROM banno/carbon-base:latest  
  
RUN pip install boto==2.38.0  
  
ADD . /opt/whisper-backup  
  
RUN cd /opt/whisper-backup && python setup.py install  
  
WORKDIR /opt/whisper-backup/whisperbackup  
  
ENTRYPOINT ["python", "whisperbackup.py"]  

