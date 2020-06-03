FROM ubuntu:latest  
RUN apt-get update && apt-get install -y python3 wget  
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py  
COPY BK /BK  
WORKDIR /BK  
RUN pip install -r requirements.txt  
CMD ["python3","roburger.py"]  

