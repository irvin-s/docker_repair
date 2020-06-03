FROM python:2.7.11-alpine  
  
RUN pip install requests  
  
ADD . /src  
  
# UDP  
EXPOSE 1812/UDP  
  
CMD ["python", "/src/proxy.py"]  

