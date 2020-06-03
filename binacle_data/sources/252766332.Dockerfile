FROM python:3-alpine  
  
ADD hamidun.py /usr/bin/hamidun  
  
RUN pip install docker-py && \  
chmod +x /usr/bin/hamidun  
  
CMD ["/usr/bin/hamidun"]  

