FROM debian:stable  
  
MAINTAINER Clifton Barnes <clifton.a.barnes@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y python python-dev python-pip python-smbus  
  
EXPOSE 80  
ADD www /var/www/rovercode/www  
  
WORKDIR /var/www/rovercode/www  
RUN pip install -r requirements.txt  
  
WORKDIR /var/www/rovercode/www/Adafruit_Python_GPIO  
RUN python setup.py install  
WORKDIR /var/www/rovercode/www  
RUN echo 'python app.py' > /usr/bin/run.sh  
ENTRYPOINT ["bash", "/usr/bin/run.sh"]  

