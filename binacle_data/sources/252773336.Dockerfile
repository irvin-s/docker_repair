FROM mongo:3.0  
RUN apt-get update && apt-get install -y pwgen  
  
ENV AUTH yes  
ENV STORAGE_ENGINE wiredTiger  
ENV JOURNALING yes  
  
ADD run.sh /run.sh  
ADD set_mongodb_password.sh /set_mongodb_password.sh  
  
EXPOSE 27017 28017  
CMD ["/run.sh"]  

