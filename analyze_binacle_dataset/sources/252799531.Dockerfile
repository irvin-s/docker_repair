FROM vger/nginx:latest  
  
MAINTAINER <docker@vger.name>  
  
RUN apt-get update && apt-get install -y \  
git  
  
COPY run-website /usr/local/bin/run-website  
RUN chmod +x /usr/local/bin/run-website  
  
CMD ["/usr/local/bin/run-website"]  

