FROM docker:1.12.3  
COPY run.sh /run.sh  
RUN chmod +x /run.sh  
ENTRYPOINT /run.sh  
  
ENV WEAVE_IMAGE weaveworks/weave-kube:1.8.2  

