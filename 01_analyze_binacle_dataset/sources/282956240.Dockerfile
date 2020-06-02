FROM frolvlad/alpine-oraclejdk8
VOLUME /tmp
COPY ./target/lib/*.jar /lib/
ENV JAVA_OPTS="\
 -server \
 -Djava.security.egd=file:/dev/./urandom\
 -Xms16m\
 -Xmx48m\
 -XX:MaxMetaspaceSize=64m\
 -XX:CompressedClassSpaceSize=8m\
 -Xss256k\
 -Xmn20m\
 -XX:InitialCodeCacheSize=4m\
 -XX:ReservedCodeCacheSize=8m\
 -XX:MaxDirectMemorySize=16m"