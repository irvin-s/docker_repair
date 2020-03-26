FROM relateiq/storm-base

ADD storm.yaml /storm/conf/storm.yaml
ADD storm-supervisor-start.sh storm/storm-supervisor-start.sh


# vols
RUN mkdir /data
RUN mkdir /logs
VOLUME [ "/logs" ]
VOLUME [ "/data" ]

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 6704
EXPOSE 6705
EXPOSE 6706
EXPOSE 6707
EXPOSE 6708

CMD ["storm/storm-supervisor-start.sh"]
