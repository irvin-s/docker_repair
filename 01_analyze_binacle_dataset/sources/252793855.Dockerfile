FROM alpine:edge  
  
# Update the image with the latest packages (recommended)  
RUN apk add --update nginx gettext && rm -rf /var/cache/apk/*  
  
ADD assets /assets  
WORKDIR /etc/nginx  
EXPOSE 80  
ENTRYPOINT ["/assets/entrypoint.sh"]  

