FROM alpine:3.7  
LABEL maintainer "pete@digitalidentitylabs.com"  
  
RUN apk add --update --no-cache \  
openldap \  
openldap-backend-all \  
openldap-clients \  
openldap-mqtt \  
openldap-overlay-all \  
openldap-passwd-pbkdf2  
  
COPY source/openldap /etc/openldap  
  
USER root  
EXPOSE 389  
ENTRYPOINT exec /etc/openldap/startup.sh

