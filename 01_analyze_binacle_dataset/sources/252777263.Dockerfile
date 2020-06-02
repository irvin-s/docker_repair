FROM nginx:alpine  
  
RUN apk add openssl curl --no-cache  
  
RUN curl https://get.acme.sh | sh  
  
RUN ln -s /root/.acme.sh/acme.sh /usr/bin/acme.sh

