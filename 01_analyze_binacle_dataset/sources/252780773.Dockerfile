FROM badele/debian-mosquitto  
MAINTAINER Bruno Adelé "bruno@adele.im"  
# Supervisor  
RUN apt-get install -y supervisor  
  
# Add serialkiller-plugins  
RUN pip3 install git+git://github.com/badele/serialkiller-plugins.git  
  
# Add files  
ADD files/serialkiller/mqtt/pub/weather_montpellier.py /usr/local/bin/  
ADD files/serialkiller/mqtt/pub/currenttime.py /usr/local/bin/  
ADD files/supervisord/ /etc/supervisor/conf.d/  
  
CMD /usr/bin/supervisord -n

