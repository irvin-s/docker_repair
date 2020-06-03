# our base image  
FROM alpine:3.7  
# Install python and pip  
RUN apk add --update py2-pip  
  
# upgrade pip  
RUN pip install --upgrade pip  
  
# install Python modules needed  
COPY requirements.txt /usr/src/barometer/  
  
RUN apk add linux-headers  
  
RUN apk --update add --virtual build-dependencies python-dev build-base \  
&& pip install -r /usr/src/barometer/requirements.txt \  
&& apk del build-dependencies  
  
# copy files required for the barometer to run  
RUN mkdir -p /app  
  
WORKDIR /app  
COPY . /app  
ENTRYPOINT python barometer.py  
  
# tell the port number the container should expose  
EXPOSE 8086  
EXPOSE 8083  

