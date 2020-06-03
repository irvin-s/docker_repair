FROM node:10.15.3-jessie AS build-js

# see https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#non-root-user
USER node
WORKDIR /home/node

COPY --chown=node package*.json ./
RUN npm install --only=production

COPY --chown=node Gruntfile.js ./
COPY --chown=node src/main/resources/public/js ./src/main/resources/public/js
RUN npm run --silent grunt-build

FROM gradle:5.4.0-jdk8-alpine AS build-java

USER gradle
RUN mkdir -p /home/gradle/app/build/resources/main/public/js
WORKDIR /home/gradle/app

COPY --chown=gradle build.gradle .
COPY --chown=gradle src ./src
RUN rm -f src/main/resources/public/js/*.js
COPY --chown=gradle --from=build-js /home/node/build/resources/main/public/js/app.min.js ./src/main/resources/public/js/

RUN gradle --info build -x test

FROM adoptopenjdk/openjdk8:alpine-jre

LABEL maintainer="Sebastian Peters <Sebastian.Peters@gmail.com>"

ENV USER lvz-viz

RUN addgroup $USER \
  && adduser -D -G $USER -S $USER

USER $USER
WORKDIR /home/$USER

COPY --chown=lvz-viz dewac_175m_600.crf.ser.gz .
COPY --chown=lvz-viz --from=build-java /home/gradle/app/build/libs/*.jar ./app.jar

EXPOSE 8080

ENTRYPOINT ["java","-XshowSettings:vm","-XX:+UnlockExperimentalVMOptions","-XX:+UseCGroupMemoryLimitForHeap","-XX:MaxRAMFraction=1","-Djava.security.egd=file:/dev/./urandom","-jar","./app.jar"]
