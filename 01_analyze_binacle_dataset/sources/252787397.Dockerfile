FROM python:3.4  
MAINTAINER Aleh Humbar og@gsl.tv  
  
ADD . /  
  
RUN ls -al  
  
RUN pip install -r req.txt  
  
EXPOSE 5000  
ENTRYPOINT python var/www/html/bin/run.py -w 4  
  
# ENTRYPOINT /usr/bin/tail -f /dev/null

