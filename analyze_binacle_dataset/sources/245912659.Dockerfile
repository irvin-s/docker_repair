FROM alpine:3.6 as builder

#
# Download the JDK 11 for Alpine Linux distribution
#
ARG OPENJDK11_ALPINE_URL=https://download.java.net/java/early_access/alpine/11/binaries/openjdk-11-ea+11_linux-x64-musl_bin.tar.gz
RUN apk update \
  && apk add ca-certificates wget \
  && mkdir -p /usr/lib/jvm \
  && wget -c -O- $OPENJDK11_ALPINE_URL \
    | tar -zxC /usr/lib/jvm

ENV LANG C.UTF-8
ENV JAVA_HOME /usr/lib/jvm/jdk-11
ENV PATH=$PATH:$JAVA_HOME/bin

WORKDIR /app
RUN mkdir -p /app/src
COPY ./src /app/src

#
# Compile the Java source code to class files
#
RUN mkdir -p build/classes/main
RUN javac -d build/classes/main \
    src/main/java/module-info.java \
    src/main/java/fi/linuxbox/http/Main.java

#
# Package the class files as a modular JAR
#
RUN mkdir -p build/jmods
RUN jar --create --file build/jmods/http-server-1.0-SNAPSHOT.jar \
    --main-class fi.linuxbox.http.Main \
    -C build/classes/main .

#
# Create an optimized custom runtime
#
ENV TARGET_JMODS=$JAVA_HOME/jmods
RUN jlink --module-path build/jmods:$TARGET_JMODS \
          --strip-debug --vm server --compress 2 \
          --class-for-name \
          --no-header-files --no-man-pages \
          --dedup-legal-notices=error-if-not-same-content \
          --add-modules http.server \
          --output build/jre/native

#
# Builder Stage is all done
#
FROM alpine:3.6

COPY --from=builder /app/build/jre/native /app

CMD ["/app/bin/java", "-m", "http.server"]
