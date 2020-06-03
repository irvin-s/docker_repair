FROM nginx  
WORKDIR /app  
RUN apt-get update  
RUN apt-get install -y python3.2  
RUN apt-get install -y python3-pip python-psycopg2 libpq-dev  
RUN apt-get install -y supervisor  
RUN service supervisor stop  
RUN apt-get clean all  
RUN groupadd -r mediaTek \  
&& useradd -r -g mediaTek mediaTek  
ADD requirements.txt /app/  
RUN pip-3.2 install -r requirements.txt  
RUN pip-3.2 install supervisor-stdout  
  
ADD deploy_tools/start-srv.sh /src/  
  
ADD ./deploy_tools/supervisord.conf /etc/supervisor/conf.d/mediaTek.conf  
ADD ./deploy_tools/nginx.conf /etc/nginx/nginx.conf  
# restart nginx to load the config  
RUN service nginx stop  
  

