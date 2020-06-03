FROM dmoj/judge-base-medium:latest  
  
COPY judge.yml /judge/  
USER judge  
  
ENTRYPOINT ["/judge/docker-entry"]  

