FROM relateiq/storm-base

ADD storm.yaml /storm/conf/storm.yaml
ADD storm-ui-start.sh storm/storm-ui-start.sh

# vols
RUN mkdir /data
RUN mkdir /logs
RUN mkdir /init
VOLUME [ "/logs" ]
VOLUME [ "/data" ]
VOLUME [ "/init" ]

EXPOSE 8080

CMD ["storm/storm-ui-start.sh"]
