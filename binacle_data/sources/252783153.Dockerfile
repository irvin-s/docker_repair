FROM alpine  
RUN apk --no-cache add gnupg  
ENTRYPOINT ["gpg"]  

