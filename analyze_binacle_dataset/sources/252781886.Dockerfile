FROM alpine:3.2  
MAINTAINER Christian Blades <christian.blades@careerbuilder.com>  
  
RUN apk -U add nodejs && npm install -g stubby@0.2.11  
  
EXPOSE 8889 8882 7443  
ENTRYPOINT "stubby"  

