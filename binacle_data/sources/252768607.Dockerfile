FROM gliderlabs/alpine:3.2  
RUN apk update  
RUN apk add ruby ruby-dev  
RUN gem install certificate_authority  
ADD ./certgen.rb /root/certgen.rb  
  
WORKDIR /root  
  
VOLUME "/root/.docker"  
  
ENTRYPOINT ["ruby","/root/certgen.rb"]  

