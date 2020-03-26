FROM alpine:latest  
RUN apk --no-cache add ca-certificates  
  
FROM opensuse:leap  
LABEL maintainer="Eugene Istomin <eugene.istomin@gmail.com>"  
RUN zypper in -y python  
ENTRYPOINT ["/bin/echo"]  
CMD ["hi"]  

