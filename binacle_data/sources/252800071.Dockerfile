FROM alpine  
  
LABEL maintainer="dingdayu <614422099@qq.com>" \  
version="v1.3" \  
description="JetBrainsLicenseServer"  
  
ADD JetBrainsLicenseServer_amd64 /app/  
ADD main.sh /app/  
WORKDIR /app  
EXPOSE 1228  
ENV USER_NAME "dingdayu"  
CMD ["./main.sh"]  

