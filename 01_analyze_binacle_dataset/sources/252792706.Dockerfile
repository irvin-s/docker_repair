FROM alpine:edge  
  
LABEL maintainer "https://github.com/danielguerra69"  
  
RUN apk add --update --no-cache nginx  
  
RUN mkdir -p /run/nginx /usr/share/nginx/html  
  
RUN chown -R nginx:nginx /run/nginx /usr/share/nginx/html  
  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
EXPOSE 80  
STOPSIGNAL SIGTERM  
  
CMD ["nginx", "-g", "daemon off;"]  

