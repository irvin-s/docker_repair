#Tryton Test  
FROM calidae/tryton-compiler:latest  
  
WORKDIR /code  
  
#Setup Postgresql  
RUN apt-get update  
RUN apt-get install -y python-psycopg2 postgresql postgresql-common  
  
USER postgres  
  
RUN /etc/init.d/postgresql start && \  
psql --command "CREATE USER test_user WITH SUPERUSER PASSWORD 'test';"  
  
# Adjust PostgreSQL configuration  
RUN echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/9.5/main/pg_hba.conf  
  
ENV TRYTOND_DATABASE_URI postgresql://test_user:test@localhost:5432/  
  
#Launch postgresql server on boot"  
USER root  
CMD service postgresql start

