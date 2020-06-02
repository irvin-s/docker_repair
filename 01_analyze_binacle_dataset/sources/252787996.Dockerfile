FROM python:3  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /code  
WORKDIR /code  
ADD requirements.txt /code/  
  
#ENV http_proxy http://169.154.0.13:3128/  
#ENV https_proxy https://169.154.0.13:3128/  
RUN pip install --trusted-host pypi.python.org -r requirements.txt  
EXPOSE 8000  
ADD . /code/  
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

