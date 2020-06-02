FROM python:3  
RUN apt-get update && apt-get install -y \  
netcat \  
git \  
build-essential \  
libpq-dev curl \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip install --upgrade pip && pip install \  
psycopg2 \  
ipython \  
pudb \  
gunicorn \  
requests \  
python-dateutil \  
&& rm -rf ~/.cache/pip/*  
  
COPY wait-for.sh run-server.sh docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["/run-server.sh"]  

