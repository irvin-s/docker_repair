# fichier Dockerfile DEV  
FROM python:3.5.4  
ENV PYTHONUNBUFFERED 1  
ENV PYTHON_SETTINGS_MODULE=finance.settings  
  
RUN mkdir /finance  
WORKDIR /finance  
ADD . /finance/  
  
RUN mkdir /config  
ADD /config/requirements.txt /config/  
  
RUN pip install -r /config/requirements.txt  
  
VOLUME .:/finance  
  
EXPOSE 8000:8000  
CMD python manage.py runserver 0.0.0.0:8000 --settings=finance.settings  
  

