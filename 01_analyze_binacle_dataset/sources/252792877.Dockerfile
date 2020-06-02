FROM alpine:3.3  
RUN apk add --update --update-cache bash docker  
ADD image-copy /usr/bin/image-copy  
CMD ["image-copy"]  

