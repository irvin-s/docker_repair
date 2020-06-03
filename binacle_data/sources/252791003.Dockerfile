FROM gitlab/gitlab-runner:alpine  
  
ADD sbin/* /sbin/  
RUN chmod +x /sbin/cat-gitlab-ci-multi-runner-config /sbin/entrypoint  
  
ENTRYPOINT [ "/sbin/entrypoint" ]  

