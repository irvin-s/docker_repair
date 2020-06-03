FROM ubuntu  
RUN apt-get update && apt-get install -y python  
COPY stitch.py .  
CMD python stitch.py  
  

