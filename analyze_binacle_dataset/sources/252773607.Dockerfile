FROM ubuntu:latest  
  
ENV LC_ALL=C.UTF-8  
ENV LANG=C.UTF-8  
RUN apt-get update && apt-get install -y \  
build-essential \  
curl \  
libffi-dev \  
libldap2-dev \  
libmysqlclient-dev \  
libsasl2-dev \  
libssl-dev \  
python3-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN curl -sL https://bootstrap.pypa.io/get-pip.py | python3  
RUN pip install \  
impyla \  
mysqlclient \  
psycopg2 \  
pyhive \  
pymssql \  
sqlalchemy-bigquery \  
sqlalchemy-redshift \  
superset  
  
RUN fabmanager create-admin \  
\--app superset \  
\--username admin \  
\--firstname admin \  
\--lastname user \  
\--email admin@fab.org \  
\--password admin  
RUN superset db upgrade  
RUN superset load_examples  
RUN superset init  
  
ENV PYTHONPATH /etc/superset  
ADD entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  

