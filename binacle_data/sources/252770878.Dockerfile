FROM alpine:3.6  
RUN apk add --update \  
poppler-utils \  
nodejs \  
nodejs-npm \  
&& npm install npm@latest -g \  
&& rm -rf /var/cache/apk/*  
  
RUN node -v  
RUN pdftotext -v  
  
CMD [ "pdftotext" ]  

