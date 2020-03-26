FROM phusion/passenger-full  
  
ADD config/webapp.conf /etc/nginx/sites-enabled/webapp.conf  
RUN mkdir /home/app/webapp  
ADD . /home/app/webapp/firstapp  
RUN chown -R app:app /home/app/webapp  
RUN chmod +x /home/app/webapp/firstapp/bin/start.sh  
RUN apt-get update  
RUN apt-get install -y libpq-dev  
  
WORKDIR /home/app/webapp/firstapp  
CMD "/home/app/webapp/firstapp/bin/start.sh"  

