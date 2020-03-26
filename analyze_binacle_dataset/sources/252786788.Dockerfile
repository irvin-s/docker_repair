FROM python:3.6  
RUN mkdir /bouker  
WORKDIR /bouker  
ADD . /bouker/  
RUN pip install -r requirements.txt  
  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
RUN chmod 777 /docker-entrypoint.sh  
  
ENV FLASK_APP=/bouker/app/wsgi.py  
EXPOSE 8000  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["init"]

