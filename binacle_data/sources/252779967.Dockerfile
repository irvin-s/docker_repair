FROM alpine  
  
MAINTAINER Elementar Sistemas <contato@elementarsistemas.com.br>  
  
RUN apk add --update nginx && mkdir /tmp/nginx && rm -rf /var/cache/apk/*  
  
# copia a configuração  
COPY config/ /etc/nginx/  
  
# copia o conteúdo html  
COPY www/ /usr/share/nginx/html/  
  
EXPOSE 80  
CMD ["nginx"]  

