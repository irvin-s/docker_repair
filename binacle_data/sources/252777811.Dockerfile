FROM ubuntu:16.04  
MAINTAINER Axel Oehmichen <axelfrancois.oehmichen11@imperial.ac.uk>  
  
WORKDIR /root  
  
ADD insert_first_user.py /root  
  
RUN apt-get update -q && apt-get upgrade -y --no-install-recommends \  
&& apt-get install -y python-dev python-pip \  
&& pip install pymongo \  
&& pip install pycrypto  
  
CMD ["python", "insert_first_user.py", "mongo:27017", "eae"]  

