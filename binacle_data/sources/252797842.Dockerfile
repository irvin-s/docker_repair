FROM python:3.5  
RUN mkdir /src  
ENV EXPIRE_TIME 120  
EXPOSE 5000  
ENV TENANT_ID=  
ENV CLIENT_ID=  
ENV CLIENT_SECRET=  
ENV SUBSCRIPTION=  
ENV PROTOCOL=  
COPY . /src  
RUN pip3 install -r /src/requirements.txt  
CMD ["python3", "/src/app.py"]  

