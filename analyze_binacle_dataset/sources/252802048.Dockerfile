FROM eeacms/apache:2.4s  
MAINTAINER "Olimpiu Rob" <olimpiu.rob@eaudeweb.ro>  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
curl \  
python2.7 && \  
rm -r /var/lib/apt/lists/*  
  
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py"  
RUN python2.7 /tmp/get-pip.py  
RUN pip install j2cli  
  
ADD src/docker-setup.sh /docker-setup.sh  

