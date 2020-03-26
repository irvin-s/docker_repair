FROM openjdk:8-alpine

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && apk add --no-cache maven@edge

RUN addgroup -S stoneboard \
  && adduser -S -G stoneboard stoneboard

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN mvn clean package

USER stoneboard
EXPOSE 5000

CMD java -Ddw.server.type=simple -Ddw.server.connector.type=http \
  -Ddw.server.connector.port.port=5000 -jar target/planning.jar server \
  ./etc/dw.yml
