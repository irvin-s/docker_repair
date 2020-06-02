FROM maven:3.3.9-jdk-8-alpine
ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}

COPY ./ /opt/app/
WORKDIR /opt/app/
RUN mvn test
