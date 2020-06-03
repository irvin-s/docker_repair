FROM appcelerator/alpine:20160928  
RUN apk update && apk upgrade && apk add ansible && rm -rf /var/cache/apk/*  
  
COPY ./* /var/ansible/  
  
VOLUME /var/ansible  
  
ENTRYPOINT ["ansible-playbook"]  
CMD ["/var/ansible/swarm.yml"]  

