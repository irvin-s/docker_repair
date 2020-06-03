FROM python:2.7  
MAINTAINER <eacon-tang@foxmail.com>  
  
  
WORKDIR /opt  
  
# clone repo  
RUN git clone https://github.com/EaconTang/ThinkBlog.git  
  
# install redis  
RUN apt-get update && \  
apt-get install -y redis-server  
  
WORKDIR /opt/ThinkBlog  
  
# install requirements  
RUN pip install -r requirements.txt  
  
# init  
RUN python manage.py makemigrations && \  
python manage.py migrate && \  
python manage.py collectstatic --noinput  
  
COPY run.sh /usr/local/bin/run  
RUN chmod +x /usr/local/bin/run  
  
EXPOSE 8000 6379  
CMD ["run"]

