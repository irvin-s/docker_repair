FROM ubuntu:17.10  
RUN apt-get update  
RUN apt-get install -y xz-utils \  
python2.7 \  
python-pip \  
git  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/*  
RUN pip install -U platformio  
  

