FROM lachlanevenson/k8s-kubectl:latest  
  
RUN apk add -q --no-cache bash bash-completion  
COPY ./files/.bashrc /root/  
ENTRYPOINT [ "bash" ]  

