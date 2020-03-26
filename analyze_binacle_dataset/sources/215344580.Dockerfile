FROM python:3.6

VOLUME /opt/c-beamd

ADD requirements.txt /requirements.txt
RUN pip install --upgrade -r /requirements.txt

EXPOSE 8000
ENTRYPOINT ["/opt/c-beamd/start"]



