FROM python:3.4.3  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
RUN \  
apt-get update -qq && \  
apt-get install -qq python python-dev && \  
rm -f /usr/local/bin/pip && \  
curl -O https://bootstrap.pypa.io/get-pip.py && \  
python2 get-pip.py && \  
python3 get-pip.py  
RUN pip2 install ansible  
  
COPY requirements.txt /usr/src/app/  
RUN pip3 install -r requirements.txt  
  
COPY . /usr/src/app  
  
RUN python3 webhook_deploy/manage.py collectstatic \--noinput  
CMD ["uwsgi", "--ini", "uwsgi.ini:production"]  

