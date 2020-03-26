FROM python:3.6-stretch  
  
# Install production dependencies.  
ADD requirements.txt /env/requirements.txt  
RUN pip install -r /env/requirements.txt  
  
# Add application to container.  
ADD . /app/  
  
WORKDIR /app/  
  
# Production entrypoint  
CMD gunicorn \  
\--bind 0.0.0.0:$PORT \  
\--workers 4 \  
\--worker-class sanic_gunicorn.Worker \  
beluga:app  

