FROM openjdk:8-jdk-alpine

VOLUME /tmp

# Set timezone
ENV TIME_ZONE Asia/Taipei
RUN apk --no-cache add \
  tzdata \
    && echo "${TIME_ZONE}" > /etc/timezone \ 
  && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

RUN mkdir /msdemo
WORKDIR /msdemo
COPY ./target/service-registry.jar ./service-registry.jar

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "service-registry.jar"]