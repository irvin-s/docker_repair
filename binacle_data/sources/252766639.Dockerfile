FROM nginx  
  
RUN apt-get update -q -y && \  
apt-get install -q -y python-setuptools wget && \  
easy_install supervisor  
  
RUN rm /etc/nginx/conf.d/*  
COPY flask.conf /etc/nginx/conf.d/flask.conf  
COPY supervisord.conf /etc/supervisord.conf  
  
EXPOSE 80  
CMD supervisord -c /etc/supervisord.conf  
  

