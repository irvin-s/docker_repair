FROM openjdk:8-jre-alpine  
COPY java.security /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/  
RUN addgroup -g 1001 -S www && adduser -u 1001 -S -G www www  
USER www

