FROM python:3.6-alpine  
  
ENV PIP_NO_BINARY=psycopg2  
  
RUN pip3.6 install pipenv \  
&& apk update \  
&& apk add bash gcc musl-dev python3-dev postgresql-dev  
  
ONBUILD ADD Pipfile /Pipfile  
ONBUILD ADD Pipfile.lock /Pipfile.lock  
ONBUILD RUN pipenv install --dev --deploy --system \  
&& apk del --purge gcc musl-dev python3-dev  
  
CMD ["python"]  

