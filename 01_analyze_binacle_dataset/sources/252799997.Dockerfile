FROM python:3.4-alpine  
ADD . /code  
WORKDIR /code  
RUN apk add --update \  
postgresql-dev \  
gcc \  
python3-dev \  
musl-dev  
RUN pip install -r requirements.txt  
CMD ["python", "manage.py"]  

