#
# To build de Docker image
# ------------------------
#
#    1) copy the ssh keys to be used to connect to the server
#        to the 'ssh-keys' directory (I know, it's ugly! Please
#        tell me if you know a better way)
#
#    2) create 'smoke_settings_local.py'
#
#    3) build the Docker image:
#
#        $ docker build -t data-tsunami.com/smoke .
#
# Launch the container
# --------------------
#
# To run interactively (so you can see the logs):
#
#     $ docker run -ti -p 8989:8080 data-tsunami.com/smoke
#

FROM ubuntu:14.04

MAINTAINER Horacio G. de Oro <hgdeoro@gmail.com>

RUN apt-get update
RUN apt-get install -y python-django redis-server python-virtualenv
RUN apt-get install -y python-dev
RUN apt-get install -y libssl-dev openssh-client

ENV RUNNING_IN_DOCKER 1

CMD ["/home/smoke/run_uwsgi.sh"]

RUN useradd --create-home --home-dir /home/smoke smoke

USER smoke

ADD requirements.txt /home/smoke/requirements.txt

RUN virtualenv -p python2.7 /home/smoke/virtualenv
RUN /home/smoke/virtualenv/bin/pip install -r /home/smoke/requirements.txt

ADD manage.py /home/smoke/manage.py
ADD run_uwsgi.sh /home/smoke/run_uwsgi.sh
ADD smoke /home/smoke/smoke

ADD smoke_settings_local.py /home/smoke/smoke_settings_local.py

RUN cd /home/smoke ; \
    /home/smoke/virtualenv/bin/python manage.py syncdb --noinput ; \
    /home/smoke/virtualenv/bin/python manage.py migrate

# COPY THE SSH KEYS

ADD ssh-keys /home/smoke/.ssh/

USER root

RUN chown -R smoke.smoke /home/smoke
RUN chmod 0700 /home/smoke/.ssh

RUN echo "smoke    ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

USER smoke
