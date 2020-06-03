FROM alpine  
  
RUN apk --update add git openssh bash && \  
rm -rf /var/lib/apt/lists/* && \  
rm /var/cache/apk/*  
  
COPY commands.sh /scripts/commands.sh  
  
RUN ["chmod", "+x", "/scripts/commands.sh"]  
  
ENTRYPOINT ["/scripts/commands.sh"]  
  
WORKDIR /

