FROM blowb/uwsgi:python2  
  
MAINTAINER Hong Xu <hong@topbug.net>  
  
RUN apt-get update && apt-get install -y --no-install-recommends git-core  
RUN pip install virtualenv  
RUN git clone https://github.com/mozilla-services/syncserver /var/uwsgi  
# check out a specific version to avoid incompatible changes (Feb 12 2015)  
RUN cd /var/uwsgi && git checkout c4c0fa033aeb08646008e4969519619178d4a12b  
# move the configuration file to /etc  
RUN mv -v /var/uwsgi/syncserver.ini /etc  
# link the configuration file to the "standard" location  
RUN ln -fvs /etc/syncserver.ini /var/uwsgi/  
RUN cd /var/uwsgi && make build  
  
ENV WSGI_FILE=/var/uwsgi/syncserver.wsgi  

