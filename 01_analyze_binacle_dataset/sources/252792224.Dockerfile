FROM nginx  
MAINTAINER chaya  
  
RUN apt-get update && apt-get install -y curl unzip jq  
  
COPY run.sh /run.sh  
RUN chmod +x /run.sh  
  
CMD ["/run.sh"]

