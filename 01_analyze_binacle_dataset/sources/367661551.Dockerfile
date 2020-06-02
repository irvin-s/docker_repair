FROM python:2.7.11
MAINTAINER jason@thesparktree.com


#Create confd folder structure
RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
RUN chmod u+x  /usr/local/bin/confd
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates

#Create rancher-events folder structure
RUN mkdir -p /srv/rancher-events/

ADD ./listener.py /srv/rancher-events/listener.py
ADD ./processor.py /srv/rancher-events/processor.py
ADD ./notify.py /srv/rancher-events/notify.py
ADD ./requirements.txt /srv/rancher-events/requirements.txt

#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh


WORKDIR /srv/rancher-events
RUN pip install -r /srv/rancher-events/requirements.txt

CMD ["/srv/start.sh"]