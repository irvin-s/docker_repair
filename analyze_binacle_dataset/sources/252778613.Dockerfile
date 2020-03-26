FROM docku/uwsgi  
MAINTAINER Jon Chen <bsd@voltaire.sh>  
  
# uwsgi binds to 0.0.0.0:8080  
EXPOSE 8080  
# install requirements  
RUN pacman -Syu --needed --noconfirm uwsgi-plugin-python python-pip  
  
# install pugstar  
RUN pip install virtualenv  
RUN mkdir -p /opt/virtualenvs/  
RUN virtualenv /opt/virtualenvs/pugstar/  
RUN /opt/virtualenvs/pugstar/bin/pip install pugstar  
  
# add uwsgi configuration  
ADD uwsgi.ini /etc/uwsgi/apps/pugstar.ini  

