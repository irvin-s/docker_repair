FROM cmp1234/jre-with-fonts:8u151-alpine3.7  
  
# grab su-exec for easy step-down from root  
RUN apk add \--no-cache 'su-exec>=0.2'  

