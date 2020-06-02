FROM python:3.6-alpine  
  
RUN apk add --no-cache --update \  
# cchardet and lxml  
g++ \  
# lxml  
musl-dev libxml2-dev libxslt-dev  
  
COPY requirements.txt /app/requirements.txt  
WORKDIR /app  
RUN pip install --disable-pip-version-check -r requirements.txt  
COPY . /app  
  
EXPOSE 8080  
ENV PORT 8080  
CMD python main.py  

