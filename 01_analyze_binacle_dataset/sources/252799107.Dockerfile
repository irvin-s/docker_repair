FROM alpine  
  
RUN apk --no-cache add curl  
ADD conf.sh /root/conf.sh  
WORKDIR /root  
  
CMD ./conf.sh

