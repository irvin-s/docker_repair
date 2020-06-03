FROM python:3-alpine  
ENV PYTHONUNBUFFERED 1  
ENV FLASK_APP todo.py  
RUN mkdir /code  
WORKDIR /code  
RUN pip install Flask  
RUN pip install todoist-python  
RUN pip install arrow  
ADD . /code/  
CMD flask run -h 0.0.0.0  

