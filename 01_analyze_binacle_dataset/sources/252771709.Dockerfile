FROM asynchrony/docker-aws  
  
COPY backup.py /backup.py  
  
ENV BACKUP_INTERVAL 60  
CMD ["python", "/backup.py"]  

