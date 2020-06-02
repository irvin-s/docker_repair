FROM ubuntu:latest

ADD requirements.txt /tmp/requirements.txt
ADD heliosburn /opt/HeliosBurn/heliosburn
# Clone the conf files into the docker container
# Will have to do once HB is public, currently need a key and a release
# RUN git clone git@github.com:emccode/HeliosBurn.git
ADD heliosburn/django/hbproject/example.env /opt/HeliosBurn/heliosburn/django/hbproject/.env
ADD install/docker/modules.yaml /opt/HeliosBurn/heliosburn/proxy/modules.yaml
ADD install/docker/config.yaml /opt/HeliosBurn/heliosburn/proxy/config.yaml
ADD install/docker/settings.py /opt/HeliosBurn/heliosburn/django/hbproject/hbproject/settings.py
ADD install/docker/proxy_settings.py /opt/HeliosBurn/heliosburn/proxy/settings.py

RUN apt-get -y update
RUN apt-get -y install python-software-properties
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get -y install ipython-notebook
RUN apt-get -y install npm
RUN apt-get -y install supervisor
RUN apt-get -y install python
RUN apt-get -y install python-pip
RUN apt-get -y install default-jre
RUN apt-get -y install openssl
RUN apt-get -y install build-essential
RUN apt-get -y install python-dev
RUN apt-get -y install libyaml-dev
RUN apt-get -y install libpython2.7-dev
RUN sed -i "s/DJANGO_SECRET_KEY.*/DJANGO_SECRET_KEY="'$(openssl rand -hex 16)'"/" /opt/HeliosBurn/heliosburn/django/hbproject/.env
#Temporary, should pull out of hblog.py
RUN sed -i "s/redis_host = 'loc.*/redis_host="\'redis\'"/" /opt/HeliosBurn/heliosburn/hblog/hblog.py
RUN sed -i "s/mongodb_host = 'loc.*/mongodb_host="\'mongo\'"/" /opt/HeliosBurn/heliosburn/hblog/hblog.py
RUN pip install -r /tmp/requirements.txt
ADD install/etc/supervisor/conf.d/*.conf /etc/supervisor/conf.d/
#RUN python /opt/HeliosBurn/heliosburn/django/hbproject/create_db_model.py
EXPOSE 80
CMD ["/usr/bin/supervisord", "-n"]
