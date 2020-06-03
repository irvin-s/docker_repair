FROM python:3.6  
ADD . /client  
WORKDIR /client  
RUN pip install -r requirements.txt  
CMD [ "python", "./client.py" ]

