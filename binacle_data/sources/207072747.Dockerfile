FROM unocha/alpine-base-s6:%%UPSTREAM%%

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="nginx" \
      org.label-schema.description="This service provides a base nginx platform capable of authenticating users through pam." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="%%UPSTREAM%%" \
      info.humanitarianresponse.nginx="1.12.2-r5"

WORKDIR /src

COPY . .

# Install nginx.
RUN mkdir -p /etc/services.d/nginx /etc/services.d/nslcd /run/nginx /srv/www/html /var/log/nginx /var/cache/nginx && \
    apk update && \
    apk upgrade && \
    apk add \
        nss-pam-ldapd && \
    echo "/src/packages/main" >> /etc/apk/repositories && \
    apk update --allow-untrusted && \
    apk add --allow-untrusted \
        nginx-mod-http-auth-pam \
        nginx-mod-http-lua \
        nginx-mod-http-upload-progress && \
    mv run_nginx /etc/services.d/nginx/run && \
    mv run_nslcd /etc/services.d/nslcd/run && \
    mv default.conf /etc/nginx/conf.d/ && \
    mv index.html /srv/www/html/ && \
    rm -rf /var/cache/apk/* && \
    rm -rf /src && \
    sed -i 's|/src/packages/main||' /etc/apk/repositories

    #apk index -o /src/packages/main/x86_64/APKINDEX.unsigned.tar.gz /src/packages/main/x86_64/*.apk && \
    #cp /src/packages/main/x86_64/APKINDEX.unsigned.tar.gz /src/packages/main/x86_64/APKINDEX.tar.gz && \

EXPOSE 80

# Volumes
# - Conf: /etc/nginx/conf.d (default.conf)
# - Logs: /var/log/nginx
# - Data: /srv/www/html
# - Cache: /var/cache/nginx
