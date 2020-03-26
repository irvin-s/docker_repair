FROM python:3.6.4-onbuild  
RUN apt-get update  
  
RUN apt-get install cron -yqq \  
curl  
  
# Copying requirements.txt file  
COPY requirements.txt requirements.txt  
  
# pip install  
RUN pip3 install --no-cache -r requirements.txt  
  
RUN mkdir /data  
RUN mkdir /notebooks  
RUN mkdir /tmp/tflearn_logs  
  
VOLUME ["/data", "/notebooks", "/tmp/tflearn_logs"]  
  
#expose jupyter port  
EXPOSE 8888  
CMD jupyter lab --no-browser --ip=0.0.0.0 --allow-root  

