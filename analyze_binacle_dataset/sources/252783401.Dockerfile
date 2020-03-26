FROM docker:git  
MAINTAINER Dean Rather <deanrather@gmail.com>  
  
RUN apk add --update \  
bash \  
nodejs \  
&& rm -rf /var/cache/apk/*  
  
CMD ["bash"]  

