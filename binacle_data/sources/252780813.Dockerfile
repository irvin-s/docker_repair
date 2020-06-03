FROM badoque/connectmint-docker-ubuntu1604-python35-base:latest  
  
COPY ./requirements /requirements  
  
RUN pip install -r /requirements/production.txt \  
&& groupadd -r django \  
&& useradd -r -g django django  
  
COPY . /app  
RUN chown -R django /app  
  
WORKDIR /app  
  
RUN mkdir /app/env  
RUN touch /app/env/production  
  
EXPOSE 8080  
CMD gunicorn config.wsgi -b 0.0.0.0:8080 --chdir=/app

