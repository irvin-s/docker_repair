FROM python:2.7  
MAINTAINER Tim Leguijt "tim@leguijtict.nl"  
RUN apt-get update && \  
apt-get install -y postgresql-client && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENV PYTHONPATH=/home/app/webapp  
ENV DJANGO_SETTINGS_MODULE=goodquestions.settings.base  
  
# Setup python env  
ADD conf/requirements /pd_build/requirements  
RUN pip install -r /pd_build/requirements/deploy.txt  
  
ADD docker/ /pd_build/  
RUN /pd_build/bin/configure.sh  
  
ADD goodquestions /home/app/webapp/goodquestions  
ADD import /home/app/webapp/import  
  
RUN chown -R app:app /home/app && \  
setuser app django-admin.py collectstatic --noinput  
  
VOLUME /home/app/webapp/static  
VOLUME /etc/nginx/conf.d/  
  
WORKDIR /home/app  
  
ENTRYPOINT ["./scripts/gqadmin"]  
CMD ["run"]  

