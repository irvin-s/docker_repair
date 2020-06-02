FROM gliderlabs/alpine:3.3  
MAINTAINER Eugeny Birukov <e.birukov@corpwebgames.com>  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache bash git openssh  
  
ADD scripts/restore.sh /restore.sh  
  
CMD ["./restore.sh"]  
  
  
  

