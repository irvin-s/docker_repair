FROM phusion/passenger-full  
  
RUN apt-get update -y && apt-get install -y git curl python-pip jq  
  
RUN mkdir src output app  
VOLUME ["/output"]  
  
COPY requirements.txt /app  
RUN pip install -r /app/requirements.txt  
  
COPY ./src /src  
COPY ./deploy /usr/local/bin/deploy  
COPY ./fiab /usr/local/bin/fiab  
COPY ./update-firecloud-service /usr/local/bin/update-firecloud-service  
COPY ./github /usr/local/bin/github  
COPY ./instance.sh /usr/local/bin/instance  
COPY ./configure.rb /usr/local/bin/configure  
  
RUN nosetests  
  
RUN [ "bash" ]  

