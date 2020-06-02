FROM ubuntu  
MAINTAINER Stefan Schindler <docker-tryton@boxbox.org>  
  
RUN apt-get update  
RUN apt-get install -y python-dev python-pip  
RUN apt-get install -y libxml2-dev libxslt1-dev  
RUN apt-get install -y zlib1g-dev  
RUN apt-get install -y libpq-dev  
RUN pip install postgres  
RUN pip install trytond  
  
RUN mkdir -p /app  
  
ENV ADMIN_PASSWORD admin  
ENV DB_USER tryton  
ENV DB_PASS tryton  
ENV DB_NAME tryton  
  
EXPOSE 8000  
ADD start /app/start  
CMD ["/app/start"]  

