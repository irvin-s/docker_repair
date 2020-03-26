FROM tomcat:8.5-jre8-alpine  
COPY java.security /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/  
RUN addgroup -g 1001 -S www && adduser -u 1001 -S -G www www \  
&& chown -R www:www /usr/local/tomcat  
USER www  
WORKDIR /usr/local/tomcat  
EXPOSE 8080  
EXPOSE 8009  
CMD ["catalina.sh", "run"]

