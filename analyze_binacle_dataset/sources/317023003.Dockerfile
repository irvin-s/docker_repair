FROM openjdk:11 as builder

RUN jlink \
    --add-modules java.sql,java.naming,java.management,java.instrument,java.security.jgss,java.desktop,jdk.unsupported \
    --verbose \
    --strip-debug \
    --compress 2 \
    --no-header-files \
    --no-man-pages \
    --output /opt/jre-minimal

FROM panga/alpine:3.8-glibc2.27

COPY --from=builder /opt/jre-minimal /opt/jre-minimal

ENV LANG=C.UTF-8 \
    PATH=${PATH}:/opt/jre-minimal/bin

ADD modules /opt/app/modules

ARG JVM_OPTS
ENV JVM_OPTS=${JVM_OPTS}

CMD java ${JVM_OPTS} \
    --add-opens java.base/java.lang=spring.core,javassist \
    --module-path /opt/app/modules \
    --module spring.petclinic
