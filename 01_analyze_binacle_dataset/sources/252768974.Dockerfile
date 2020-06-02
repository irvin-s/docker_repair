FROM python  
MAINTAINER Andrii Abaimov <a.abaimov@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends nginx supervisor && \  
pip install uwsgi && \  
rm -rf /var/lib/apt/lists/* && \  
echo "daemon off;" >> /etc/nginx/nginx.conf  
COPY config/nginx-app.conf /etc/nginx/sites-available/default  
COPY config/supervisor-app.conf /etc/supervisor/conf.d/  
COPY config/uwsgi.ini config/uwsgi_params /etc/uwsgi/  
  
WORKDIR /usr/src/app  
COPY requirements.txt .  
RUN pip install -r requirements.txt  
COPY src .  
  
EXPOSE 80  
CMD ["supervisord", "-n"]  

