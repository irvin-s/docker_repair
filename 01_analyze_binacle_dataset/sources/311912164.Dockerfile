FROM openjdk:8-jdk-alpine
VOLUME /tmp
RUN apk --no-cache --update add bash
RUN apk add curl
RUN mkdir -p /opt/corda
COPY node.conf /opt/notaries/node.conf
COPY corda.jar /opt/notaries/corda.jar

WORKDIR /opt/corda
RUN export PUBLIC_ADDRESS=localhost && cd /opt/corda && java -jar /opt/notaries/corda.jar --just-generate-node-info --base-directory=/opt/notaries
WORKDIR /

COPY start.sh start.sh
RUN chmod +x start.sh
EXPOSE 8080
EXPOSE 10200
COPY app.jar app.jar
RUN mkdir -p /jars
VOLUME ["/jars"]
ENTRYPOINT ["/start.sh"]
