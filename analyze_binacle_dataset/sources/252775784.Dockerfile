FROM blowb/uwsgi:python2  
  
MAINTAINER Hong Xu <hong@topbug.net>  
  
RUN docker-install-uwsgi-plugin greenlet  
  
# We probably need to manually manage the database with sqlite  
RUN apt-get update && apt-get install -y sqlite3  
  
RUN pip install isso==0.10.3  
  
# You must create a volume to put the config file isso.conf in that volume.  
RUN mkdir -v /etc/isso  
VOLUME /etc/isso  
  
# spooler  
RUN mkdir -vp /tmp/isso/mail && chown -vR uwsgi.uwsgi /tmp/isso  
  
ENV ADDITIONAL_ARGUMENTS="--gevent 50 --spooler /tmp/isso/mail"  
ENV WSGI_MODULE=isso.run ISSO_SETTINGS=/etc/isso/isso.conf  

