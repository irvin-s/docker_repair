FROM java:8-jre-alpine

COPY build/epflbot.jar /opt/

RUN echo "Europe/Zurich" > /etc/timezone

CMD ["java", "-jar", "/opt/epflbot.jar"]