FROM alpine:3.5  
MAINTAINER brick  
  
COPY ./IntelliJIDEALicenseServer_linux_amd64 /  
  
RUN chmod a+x \  
/IntelliJIDEALicenseServer_linux_amd64  
  
EXPOSE 1017  
ENTRYPOINT ["/IntelliJIDEALicenseServer_linux_amd64"]  

