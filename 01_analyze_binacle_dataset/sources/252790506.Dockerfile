FROM debian:wheezy  
RUN apt-get update && apt-get -y install python  
ADD https://bootstrap.pypa.io/get-pip.py /get-pip.py  
RUN python get-pip.py && rm /get-pip.py  

