FROM centos:latest

RUN yum install -y java-1.8.0-openjdk-devel
RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
    yum install -y sbt
WORKDIR /src/kind-sir
COPY ./ ./
RUN sbt assembly
ENTRYPOINT ["java", "-Dconfig.file=config.conf", "-jar", "kind_sir.jar"]
