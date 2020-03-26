FROM alpine:3.7  
RUN apk update && \  
apk add --no-cache ansible && \  
rm -rf /tmp/* && \  
rm -rf /var/cache/apk/*  
  
# Add volume for Ansible playbooks  
VOLUME /ansible  
COPY ansible/probe.yml ansible/site.yml  
WORKDIR /ansible  
  
# Entrypoint  
ENTRYPOINT ["ansible-playbook"]  
CMD ["site.yml"]  

