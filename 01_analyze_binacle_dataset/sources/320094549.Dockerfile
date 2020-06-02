FROM alpine:3.7
RUN apk --update --no-cache add openjdk8-jre && rm -rf /var/cache/apk/*
ENV JAVA_HOME /usr/lib/jvm/default-jvm
CMD ["/usr/bin/java", "-version"]
