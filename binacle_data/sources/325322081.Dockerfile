FROM oraclelinux:7-slim
ADD openjdk-11+28_linux-x64_bin.tar.gz /opt/jdk
ENV PATH=$PATH:/opt/jdk/jdk-11/bin

CMD ["java", "-showversion", "-XX:+PrintFlagsFinal"]
