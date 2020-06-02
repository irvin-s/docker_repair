FROM python:3-alpine  
WORKDIR /srv/app  
RUN pip install flask  
COPY . /srv/app  
CMD /srv/app/start.py  

