FROM alpine:3.6  
ENV CRONTAB_ENTRY=""  
RUN rm -rf /var/cache/apk/*  
  
COPY docker-entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["sh", "/entrypoint.sh"]  
  
CMD ["crond", "-f", "-l", "0"]  

