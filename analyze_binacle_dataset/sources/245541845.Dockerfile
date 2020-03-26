FROM python:2.7.15-jessie

# based on https://github.com/pfichtner/docker-mqttwarn

# install python libraries (TODO: any others?)
RUN pip install paho-mqtt requests 

# build /opt/mqttwarn
RUN mkdir -p /opt/paradox
WORKDIR /opt/paradox

# add user mqttwarn to image
RUN groupadd -r paradox && useradd -r -g paradox paradox
RUN chown -R paradox /opt/paradox

# process run as mqttwarn user
USER paradox

# conf file from host
VOLUME ["/opt/paradox/conf"]

# set conf path
ENV PARADOXINI="/opt/paradox/conf/config.ini"

# finally, copy the current code (ideally we'd copy only what we need, but it
#  is not clear what that is, yet)
COPY . /opt/paradox

# run process
CMD python IP150MQTTv2.py

