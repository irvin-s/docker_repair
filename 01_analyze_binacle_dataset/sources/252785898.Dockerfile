FROM python:2.7  
WORKDIR /code  
ADD requirements.txt /code/  
RUN pip install -r requirements.txt  
ADD . /code  
EXPOSE 5000  
CMD python app.py  

