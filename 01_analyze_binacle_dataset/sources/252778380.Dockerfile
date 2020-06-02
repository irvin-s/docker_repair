From ubuntu:latest  
MAINTAINER Alan Rawkins "arawkins@gmail.com"  
RUN apt-get update && apt-get install -y \  
python3 \  
python3-pip  
  
COPY . /app  
WORKDIR /app  
RUN pip3 install -r requirements.txt  
RUN python3 create_db.py  
ENTRYPOINT ["python3"]  
CMD ["main.py"]  

