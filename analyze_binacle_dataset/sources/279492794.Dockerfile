FROM jbsukraine/oracle-jre:8

ENTRYPOINT ["/entrypoint.sh"]

ADD src/main/docker/entrypoint.sh /

RUN chmod 755 entrypoint.sh

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    JHIPSTER_SLEEP=0 \
    XMX=256m \
    JAVA_OPTS="-Xms64m -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.rmi.port=19999 -Dcom.sun.management.jmxremote.port=19999"

# add directly the war
ADD build/libs/*.war /app.war

EXPOSE 8081