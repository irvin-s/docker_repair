FROM java:8-alpine
MAINTAINER Your Name <you@example.com>

ADD target/uberjar/components-example.jar /components-example/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/components-example/app.jar"]
