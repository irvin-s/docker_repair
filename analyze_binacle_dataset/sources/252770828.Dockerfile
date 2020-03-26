######################################################  
#  
# Agave DevOps Whiskerboard  
# Tag: agaveapi/whiskerboard  
#  
# https://bitbucket.org/taccaci/agave-environment  
#  
# This image contains a Dockerized whiskerboard installation.  
# It requires a redis cache and postgres db to run properly  
#  
# docker run -d -t --name some-redis \  
# -v `pwd`/redis:/data \  
# redis:2.8 \  
# redis-server --appendonly yes  
#  
# docker run -d -t --name some-postgres \  
# -v `pwd`/pgdata/data:/data \  
# -v `pwd`/pgdata/log:/var/log/postgresql \  
# postgres:9.3  
#  
# docker run -d -t --name whiskerboard \  
# -v `pwd`/whiskerboard/logs:/whiskerboard/logs \  
# --link some-redis:redis \  
# --link some-postgres:postgres \  
# -p 8000:8000 \  
# -p 10022:22 \  
# -h docker.example.com \  
# agaveapi/whiskerboard  
#  
######################################################  
  
FROM python:2.7  
  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu>  
  
RUN apt-get autoremove -y  
RUN apt-get update -y  
RUN apt-get install -y openssh-server openssh-client  
  
RUN pip install supervisor  
  
# Add ssh user  
RUN adduser testuser && \  
echo "testuser:testuser" | chpasswd  
  
RUN echo "root:root" | chpasswd  
  
ADD . /usr/src/python/whiskerboard  
  
WORKDIR /usr/src/python/whiskerboard  
  
RUN pip install -r requirements.txt  
#RUN fab app:myamazingboard deploy  
  
ADD supervisord.conf /etc/supervisord.conf  
RUN mkdir /var/log/supervisor  
RUN chmod -R 777 /var/log/supervisor  
RUN mkdir /var/run/sshd  
  
VOLUME /whiskerboard/logs  
EXPOSE 8000 22  
#CMD ["./manage.py", "runserver"]  
CMD /usr/local/bin/supervisord  

