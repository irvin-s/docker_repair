FROM python:2.7  
WORKDIR /code  
COPY ./requirements.txt /code/requirements.txt  
  
# invalidate cache only if requirements change  
RUN pip install -r requirements.txt  
  
USER 1000  
COPY ./ /code  

