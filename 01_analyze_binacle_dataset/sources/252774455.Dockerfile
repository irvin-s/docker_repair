#track latest alpine for time being  
FROM ghost:0-alpine  
  
#leave this first as it takes ages  
RUN chown -R node:node /usr/src/ghost/  
RUN apk add --no-cache sqlite  
  
#Do production by default  
ENV NODE_ENV=production  
  
#Note there is a volume at /var/lib/ghost  
COPY docker-entrypoint.sh /usr/local/bin/  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
EXPOSE 2368  
CMD ["node", "index"]  

