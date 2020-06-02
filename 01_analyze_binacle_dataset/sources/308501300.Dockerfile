FROM java:8-alpine
MAINTAINER Your Name <you@example.com>

ADD target/uberjar/krueger.jar /krueger/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/krueger/app.jar"]
