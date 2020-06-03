FROM registry.lubanresearch.com:5000/baseui:0.1
VOLUME /tmp
ENV JAVA_OPTS="\
 -server \
 -Djava.security.egd=file:/dev/./urandom\
 -Xms128m\
 -Xmx128m\
 -XX:MaxMetaspaceSize=128m\
 -XX:CompressedClassSpaceSize=20m\
 -Xss256k\
 -Xmn32m\
 -XX:InitialCodeCacheSize=4m\
 -XX:ReservedCodeCacheSize=8m\
 -XX:MaxDirectMemorySize=16m"
ENTRYPOINT java ${JAVA_OPTS} -jar /app.jar --spring.profiles.active=prod
COPY ./target/customerui.jar app.jar