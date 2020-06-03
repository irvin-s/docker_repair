FROM tiangolo/uwsgi-nginx-flask:flask  
RUN pip install Flask  
ADD . /code  
WORKDIR /code  
CMD python app.py

