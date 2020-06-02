FROM ubuntu  
  
RUN apt-get update \  
&& apt-get install -y \  
python-pip \  
python-dev \  
libhdf5-dev \  
python-pandas  
  
COPY requirements.txt /requirements.txt  
RUN pip install -r requirements.txt \  
&& rm /requirements.txt  
  
VOLUME /data  
WORKDIR /data

