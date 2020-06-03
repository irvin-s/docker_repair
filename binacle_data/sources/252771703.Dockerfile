FROM jenkins:alpine  
  
USER root  
  
ENV GIT_IDEMPOTENCE_FLAG .git/chef.flag  
ENV GIT_BRANCH master  
  
RUN apk add --no-cache su-exec python py-pip \  
&& pip install awscli  
  
COPY run-root.sh /usr/local/bin/run-root.sh  
COPY run-jenkins.sh /usr/local/bin/run-jenkins.sh  
  
ENTRYPOINT ["/bin/tini", "--"]  
  
CMD ["/usr/local/bin/run-root.sh"]  

