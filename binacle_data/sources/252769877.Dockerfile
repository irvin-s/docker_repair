FROM python:2.7  
ENV PYTHONUNBUFFERED 1  
RUN apt-get update  
RUN apt-get install -y net-tools  
RUN pip install gunicorn  
RUN pip install coverage  
RUN pip install sphinx_rtd_theme  
RUN pip install Django==1.8.5  
RUN pip install argparse==1.2.1  
RUN pip install django-model-utils==2.3.1  
RUN pip install factory-boy==2.6.0  
RUN pip install fabric  
RUN pip install django-http-proxy  
RUN pip install django-debug-toolbar  
RUN pip install python-social-auth  
RUN pip install celery  
RUN pip install selenium  
RUN pip install pytest-bdd  
RUN pip install pytest-django  
RUN pip install coverage  
RUN pip install django-statsd-mozilla  
RUN pip install docker-py  
RUN pip install urllib3  
RUN pip install django-revproxy  
RUN pip install psycopg2  
RUN pip install python-memcached  

