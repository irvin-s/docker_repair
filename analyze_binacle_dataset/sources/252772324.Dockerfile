FROM python:3.6  
# set a working directory  
WORKDIR /observatory  
  
# update, upgrade  
RUN apt-get update  
  
# get git  
RUN apt-get install git-all -y  
  
# clone the repo  
RUN git clone https://github.com/mozilla/http-observatory.git .  
RUN pip install --upgrade .  
RUN pip install --upgrade -r requirements.txt  
  
COPY scan-url.py .  
  
ENTRYPOINT ["python", "scan-url.py"]  

