FROM php:7.2-apache  
  
ENV SMTP_HOST "localhost"  
ENV SMTP_PORT "25"  
ENV SMTP_USERNAME ""  
ENV SMTP_PASSWORD ""  
ENV SMTP_SECURE ""  
ENV ADMIN_USERNAME "admin"  
ENV ADMIN_PASSWORD "admin"  
# Build-time metadata as defined at http://label-schema.org  
ARG BUILD_DATE  
ARG VCS_REF  
ARG VCS_BRANCH  
ARG VERSION  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.name="Framadate" \  
org.label-schema.description="" \  
org.label-schema.url="https://www.framadate.org" \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.vcs-url="https://github.com/aquinum/framadate" \  
org.label-schema.vendor="Framasoft" \  
org.label-schema.version=$VERSION \  
org.label-schema.schema-version="1.0"  
  
ENTRYPOINT [ "bash", "/entrypoint.sh" ]  
  
COPY ./docker/ /tmp/setup  
RUN bash /tmp/setup/setup.sh  
  
COPY . /var/www/html/  
RUN bash /tmp/setup/configure.sh

