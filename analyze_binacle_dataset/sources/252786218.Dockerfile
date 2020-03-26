FROM dmoj/judge-base:latest  
  
COPY judge.yml /judge/  
USER judge  
  
ENTRYPOINT ["/judge/docker-entry"]  

