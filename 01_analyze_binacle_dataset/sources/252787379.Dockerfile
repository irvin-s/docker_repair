FROM python:3.6  
  
WORKDIR /code  
  
COPY requirements.txt /code  
RUN pip install -U pip && pip install -r requirements.txt  
  
ENV UWSGI_MANAGE_SCRIPT_NAME=1 \  
UWSGI_MOUNT=/code=app:app \  
UWSGI_CHECK_STATIC=/code/static \  
UWSGI_STATIC_INDEX=index.html \  
UWSGI_STATIC_SKIP_EXT=.py \  
UWSGI_HTTP=0.0.0.0:8080 \  
UWSGI_MASTER=1 \  
UWSGI_WORKERS=4  
  
COPY . /code  
  
CMD ["uwsgi"]  

