FROM python  
  
WORKDIR /src  
  
COPY requirements.txt /src/requirements.txt  
COPY dependencies.sh /dependencies.sh  
  
RUN ["/bin/bash", "-c", "source /dependencies.sh" ]  
  
COPY src /src  
  
CMD ["python", "/src/http-routing.py"]

