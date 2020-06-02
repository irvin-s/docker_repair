# fichier Dockerfile DEV  
FROM python:3.4  
ENV PYTHONUNBUFFERED 1  
ENV PYTHON_SETTINGS_MODULE=src.settings.local  
  
RUN mkdir /code  
WORKDIR /code  
ADD . /code/  
  
RUN pip install -r requirements.txt \  
&& python manage.py makemigrations \  
&& python manage.py migrate \  
&& python manage.py superuser \  
&& python manage.py collectstatic --no-input  
  
VOLUME .:/code  
  
EXPOSE 8080:8000  
CMD python manage.py runserver 0.0.0.0:8000 --settings=src.settings.local  
  

