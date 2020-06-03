FROM alpine:3.7  
LABEL maintainer="bastouf@protonmail.com"  
  
COPY ./bin/IntelliJIDEALicenseServer_linux_amd64 /usr/local/bin  
  
ENTRYPOINT ["/usr/local/bin/IntelliJIDEALicenseServer_linux_amd64"]  
  
EXPOSE 1027

