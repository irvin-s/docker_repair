FROM debian:jessie  
  
MAINTAINER aspir141@gmail.com  
  
ENV CARAVEL_VERSION 0.10.0  
ENV CARAVEL_HOME /home/caravel  
ENV PATH=$PATH:$CARAVEL_HOME \  
PYTHONPATH=$CARAVEL_HOME:$PYTHONPATH  
ENV CARAVEL_WEBSERVER_PORT 8088  
ENV CSRF_ENABLED True  
RUN apt-get update \  
&& apt-get install -y \  
build-essential \  
libssl-dev \  
libffi-dev \  
python-dev \  
python-pip \  
libpq-dev \  
libmysqlclient-dev  
  
RUN pip install \  
caravel==$CARAVEL_VERSION \  
psycopg2==2.6.2 \  
mysqlclient==1.3.7 \  
sqlalchemy-redshift==0.5.0  
  
RUN mkdir $CARAVEL_HOME  
WORKDIR $CARAVEL_HOME  
COPY caravel .  
  
RUN useradd -U caravel && \  
mkdir $CARAVEL_HOME/db && \  
chown -R caravel:caravel $CARAVEL_HOME  
  
USER caravel  
  
EXPOSE $CARAVEL_WEBSERVER_PORT  
  
ENTRYPOINT ["caravel"]  
CMD ["runserver"]

