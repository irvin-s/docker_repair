FROM alpine:edge  
  
COPY entrypoint.sh /  
  
RUN apk --no-cache add mongodb && \  
rm -rf /usr/bin/mongo?* && \  
chmod u+x /*.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

