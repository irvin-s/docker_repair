FROM python:2-alpine  
EXPOSE 5000  
# Install basic utilities  
RUN apk add -U \  
ca-certificates \  
&& rm -rf /var/cache/apk/* \  
&& pip install --no-cache-dir \  
setuptools \  
wheel  
  
# This is failing for some odd pip upgrade error commenting out for now  
#RUN pip install --upgrade pip  
ADD . /app  
WORKDIR /app  
RUN pip install --requirement ./requirements.txt  
  
CMD [ "python", "./drum_spark/drum_spark.py" ]  

