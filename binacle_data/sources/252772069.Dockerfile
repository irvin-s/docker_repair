FROM augustash/alpine-base-s6:1.0.2  
# envrionment  
ENV GOPATH "/root/go"  
ENV MAIL_STORAGE="memory" \  
MAIL_SMTP_PORT="1025" \  
MAIL_API_PORT="8025" \  
MAIL_HOSTNAME="mailhog.dev"  
# packages & configure  
RUN apk-install --virtual build-dependencies build-base go git && \  
mkdir -p ${GOPATH} && \  
go get github.com/mailhog/MailHog && \  
mv ${GOPATH}/bin/MailHog /usr/local/bin/mailhog && \  
rm -rf ${GOPATH} && \  
apk-remove build-dependencies build-base && \  
apk-cleanup  
  
# copy root filesystem  
COPY rootfs /  
  
# external  
EXPOSE 1025 8025  
WORKDIR /src  
  
# run s6 supervisor  
ENTRYPOINT ["/init"]  

