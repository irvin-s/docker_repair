ARG alpine_tag=latest  
FROM alpine:${alpine_tag}  
LABEL maintainer=dpyro  
  
RUN apk add --no-cache libressl  
  
COPY ./gen_cert.sh /usr/local/bin/  
RUN chmod +x ./usr/local/bin/gen_cert.sh && \  
mkdir /certs  
  
WORKDIR /certs  
  
ENTRYPOINT [ "/usr/local/bin/gen_cert.sh" ]  
  
VOLUME [ outdir ]

