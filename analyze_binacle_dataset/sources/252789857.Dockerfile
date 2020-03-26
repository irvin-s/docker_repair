FROM callsamleung/py3ansible:latest  
MAINTAINER callsamleung@gmail.com  
  
ADD dkwebhook /srv/dkwebhook  
ADD deploy /srv/deploy  
ADD requirements.txt /srv/requirements.txt  
RUN pip install -r /srv/requirements.txt  
WORKDIR /srv/  
CMD ["uwsgi", "-i", "deploy/dkwebhook.ini"]

