FROM python:2.7
ENV INTERVAL 5
ENV SABNBZBD_HOST localhost
ENV SABNZBD_PORT 8080
ENV SABNZBD_KEY NONE
ENV INFLUXDB_HOST localhost
ENV INFLUXDB_PORT 8086
ENV INFLUXDB_DB sabnzbd

RUN mkdir /work
COPY . /work
WORKDIR /work

RUN python setup.py install
CMD python sabnzbd_influxdb_export.py --sabnzbdhost="$SABNZBD_HOST" --sabnzbdport="$SABNZBD_PORT" --sabnzbdapikey="$SABNZBD_KEY" --influxdbhost="$INFLUXDB_HOST" --influxdbport="$INFLUXDB_PORT" --influxdbdatabase="$INFLUXDB_DB" --interval="$INTERVAL"
