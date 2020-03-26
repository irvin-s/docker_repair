FROM alpine  
RUN apk --no-cache --update add nodejs && rm /var/cache/apk/*  
COPY app.js /  
EXPOSE 6969  
ENTRYPOINT ["node","/app.js"]  

