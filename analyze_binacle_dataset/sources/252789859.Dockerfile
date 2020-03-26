FROM python:3.6  
MAINTAINER callsamleung@gmail.com  
  
  
ADD vhelpy /srv/project/vhelpy  
ADD setup.py /srv/project/setup.py  
ADD setup.cfg /srv/project/setup.cfg  
ADD tests /srv/project/tests  
ADD requirements.txt /srv/project/requirements.txt  
ADD deploy /srv/project/deploy  
WORKDIR /srv/project/  
RUN pip install -r requirements.txt && python setup.py install  
EXPOSE 3031  
CMD ["uwsgi", "deploy/vhelpy.ini"]  

