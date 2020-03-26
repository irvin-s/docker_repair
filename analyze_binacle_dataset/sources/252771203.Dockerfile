FROM cptactionhank/atlassian-bamboo:latest  
  
USER root  
  
RUN apk update && apk add docker curl  
  
COPY "start.sh" "/"  
  
ENTRYPOINT ["/start.sh"]  

