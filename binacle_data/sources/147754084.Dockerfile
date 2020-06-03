FROM openjdk:11.0.2-jre-stretch as java
WORKDIR /OWASP
RUN wget https://github.com/stevespringett/nist-data-mirror/releases/download/nist-data-mirror-1.2.0/nist-data-mirror-1.2.0.jar
RUN java -jar nist-data-mirror-*.jar mirror xml

FROM nginx:1.15.8
COPY --from=java /OWASP/mirror /usr/share/nginx/html