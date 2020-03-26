FROM orctom/java:8u65-jre
VOLUME /tmp
ADD laputa-service-example-0.2-SNAPSHOT.jar /app.jar
ENV JAVA_OPTS=""

ENTRYPOINT [ "sh", "-c", "PRIMARY_IP=`ifconfig -a|awk '/(cast)/ {print $2}'|cut -d':' -f2|head -1`;  export HOST_IP=$PRIMARY_IP;  java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
