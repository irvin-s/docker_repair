  
FROM python:2.7-alpine  
EXPOSE 5000  
ADD . /app  
WORKDIR /app  
RUN pip install --requirement ./requirements.txt  
  
CMD [ "python", "./chive_app/chive_app.py" ]

