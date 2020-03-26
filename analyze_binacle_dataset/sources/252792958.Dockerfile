FROM python:3.5.3  
ENV PYTHONUNBUFFERED 1  
RUN apt-get -y update && apt-get install -y aptitude  
RUN curl -sL https://deb.nodesource.com/setup_8.x | sh  
RUN aptitude install -y nodejs  
ADD frontend/package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p /app/frontend && cp -a /tmp/node_modules /app/frontend  
  
RUN apt-get install -y gettext libgettextpo-dev  
  
WORKDIR /app  
ADD . /app  
RUN pip install -r requirements/prod.txt --default-timeout 450  
RUN python manage.py compilemessages --use-fuzzy  
RUN cd /app/frontend && npm run build  
  
EXPOSE 8000  

