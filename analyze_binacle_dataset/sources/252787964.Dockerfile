FROM alpine  
RUN apk add --update nodejs nodejs-npm && npm install npm@latest -g  
RUN npm install -g create-react-app  
WORKDIR /app  
COPY entrypoint.sh /usr/local/bin/  
COPY Makefile /usr/share/  
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]  
CMD []  

