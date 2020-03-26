FROM alpine:3.7  
ENV TZ Asia/Shanghai  
  
RUN apk add --update --no-cache tzdata squid libldap  
COPY conf/squid.conf /etc/squid/squid.conf  
COPY basic_ldap_auth /usr/lib/squid/  
COPY docker-compose.yml /  
CMD [ "/usr/sbin/squid", "-N" ]  
EXPOSE 3128 3130  

