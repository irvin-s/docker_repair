FROM python:3  
RUN apt-get update -y && \  
apt-get install -y dnsutils  
RUN mkdir /app  
WORKDIR /app  
ADD requirements.txt ./  
RUN pip install -r requirements.txt  
ADD . ./  
ENTRYPOINT ["python"]  
CMD ["app.py"]  
EXPOSE 5000  

