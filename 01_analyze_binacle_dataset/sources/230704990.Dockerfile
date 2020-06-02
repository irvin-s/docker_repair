FROM java:8

RUN mkdir /app
WORKDIR /app

ADD build/libs/event-service-0.1.0.jar /app
RUN ln -sf event-service-0.1.0.jar event-service-latest.jar

CMD java -jar /app/event-service-latest.jar