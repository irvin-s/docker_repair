FROM alpine
MAINTAINER qgp9 

# BASE SET
RUN apk update && apk upgrade && apk update
RUN apk add --update bash && rm -rf /var/cache/apk/*  

# ADDITIONAL SET

# NGINX
RUN apk add --update nginx && rm -rf /var/cache/apk/*  
 
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
