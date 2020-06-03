FROM gliderlabs/alpine:3.3  
RUN apk add --no-cache bash  
RUN apk add --no-cache bc  
ADD ./bashids /  
ENTRYPOINT ["/bashids"]  

