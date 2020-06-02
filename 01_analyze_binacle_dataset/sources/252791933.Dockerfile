From jenkinsci/jnlp-slave:alpine  
  
User root  
RUN apk update  
RUN apk add \--update --no-cache openssh  
  
User jenkins  

