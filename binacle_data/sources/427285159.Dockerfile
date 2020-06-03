FROM openjdk:9-jdk

WORKDIR /app
ADD TestHttps.class /app

RUN echo "storepass=''" >> /etc/default/cacerts
RUN /usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\x57\xbe\xbc\x27\x62\xa2\x1d\x70\xff\xf2\x18\xdd\x59\x68\x01\x1f\xfe\x42\x3a\x69' > /etc/ssl/certs/java/cacerts
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

CMD [ "java", "-cp", "/app", "TestHttps", "https://www.google.com/" ]
