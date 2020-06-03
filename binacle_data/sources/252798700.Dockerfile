FROM alpine  
  
COPY install.sh /  
COPY nsenter /nsenter  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache bash && \  
bash /install.sh  
  
ENTRYPOINT [ "crond", "-f" ]  

