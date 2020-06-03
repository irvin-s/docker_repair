FROM python:2.7.9  
MAINTAINER Michael Newman, mnewman@grahamdigital.com  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y libmagickwand-dev  
RUN pip install Wand  
  
WORKDIR /tmp  
ADD ./requirements.txt /tmp/requirements.txt  
RUN pip install -Ur requirements.txt  
  
RUN mkdir -p /opt/reach-profiles  
VOLUME /opt/reach-profiles  
WORKDIR /opt/reach-profiles  
  
EXPOSE 8000  
CMD ["gunicorn", "-b=0.0.0.0:8000", "start_reflector:reflector_app"]  

