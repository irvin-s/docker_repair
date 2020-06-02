FROM alpine:edge  
  
RUN apk --no-cache add curl bash  
COPY monitor.sh /monitor.sh  
  
ENV LOAD_THRESHOLD=4 \  
WEBHOOK=""  
CMD ["/monitor.sh"]  

