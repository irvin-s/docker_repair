FROM jwilder/nginx-proxy  
MAINTAINER cloud@casestack.com  
  
COPY nginx.tmpl Procfile /app/  

