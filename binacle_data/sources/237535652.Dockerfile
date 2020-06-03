FROM openjdk:8-jre-alpine

ENV JHIPSTER_SLEEP 0

# add directly the war
ADD *.war /app.war
ADD keystore /keystore
ADD cas.cer /cas.cer



RUN sh -c 'touch /app.war'; \
keytool -import -noprompt -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -file /cas.cer -alias cas -keypass changeit -storepass changeit;


VOLUME /tmp
EXPOSE 8080
CMD echo "The application will start in ${JHIPSTER_SLEEP}s..." && \
    sleep ${JHIPSTER_SLEEP} && \
    java -Djava.security.egd=file:/dev/./urandom -jar /app.war
