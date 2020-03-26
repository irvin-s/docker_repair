FROM grahamdigital/python3.4-docker  
  
MAINTAINER Michael Newman, mnewman@grahamdigital.com  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y git gunicorn  
  
WORKDIR /tmp  
ADD ./requirements.txt /tmp/requirements.txt  
RUN pip install -Ur requirements.txt  
  
RUN ln -s /opt/python3/bin/* /usr/local/bin/  
  
RUN mkdir -p /opt/sahara-profiles  
VOLUME /opt/sahara-profiles  
WORKDIR /opt/sahara-profiles  
  
EXPOSE 8000  
CMD ["gunicorn", "-b=0.0.0.0:8000", "start_app:app"]  

