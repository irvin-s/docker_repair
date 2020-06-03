FROM mongo:3.2  
MAINTAINER Commande-Online.fr SAS  
  
COPY ./init /init-DB  
COPY ./conf /conf-DB  
RUN mkdir /init-data  
  
VOLUME /init-data  
  
RUN chmod +x /conf-DB/entrypoint.sh  
  
RUN more /conf-DB/entrypoint.sh  
RUN ls -lah /conf-DB/entrypoint.sh  
  
ENTRYPOINT ["/conf-DB/entrypoint.sh"]  
  
EXPOSE 27017  
CMD ["mongod"]

