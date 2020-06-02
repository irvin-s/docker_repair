FROM ubuntu:latest  
  
RUN apt-get update  
RUN apt-get install -y \  
python-bottle  
  
RUN mkdir -p /striche/data  
ADD striche /striche  
RUN chmod +x /striche/striche.py  
  
VOLUME /striche/data  
  
WORKDIR /striche  
  
CMD ./striche.py  

