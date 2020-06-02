FROM phusion/passenger-customizable  
  
MAINTAINER chris@cbeer.info  
  
RUN apt-get update  
RUN /build/python.sh  
RUN /build/nodejs.sh  
RUN npm install -g grunt-cli  
  
WORKDIR /home/app  
  
RUN git clone https://github.com/urbanairship/tessera.git  
  
WORKDIR /home/app/tessera  
  
RUN apt-get install -y python-pip  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN pip install -r requirements.txt && \  
pip install -r dev-requirements.txt && \  
npm install && \  
grunt  
  
ADD passenger_wsgi.py /home/app/tessera/passenger_wsgi.py  
RUN ln -s /home/app/tessera/tessera/static /home/app/tessera/public  
  
RUN inv initdb  
RUN chown -R app .  
  
# Enable uWSGI and nginx  
RUN rm -f /etc/service/nginx/down  
RUN rm /etc/nginx/sites-enabled/default  
ADD tessera.conf /etc/nginx/sites-enabled/tessera.conf  
ADD tessera-env.conf /etc/nginx/main.d/tessera-env.conf  
ADD tessera-etc-config.py /home/app/tessera/etc/config.py  
  
CMD ["/sbin/my_init"]  

