FROM ubuntu:14.04  
MAINTAINER Walid ZIOUCHE <01walid@gmail.com>  
  
RUN apt-get update && apt-get install -y git python-pip gettext  
  
RUN pip install pyparsing  
  
RUN git clone \--depth 1 https://github.com/Alfanous-team/alfanous.git  
  
RUN cd alfanous/src/alfanous-django && pip install -r requirements.txt  
  
RUN cd alfanous && make build_api && make clean_all  
  
RUN python /alfanous/src/alfanous-django/manage.py compilemessages  
  
# clean the image a bit  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENTRYPOINT ["python", "/alfanous/src/alfanous-django/manage.py"]  
  
CMD ["runserver", "0.0.0.0:8000"]  
  
EXPOSE 8000  

