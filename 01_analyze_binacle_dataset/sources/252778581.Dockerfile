FROM elasticsearch:2.3.3  
RUN bin/plugin install mapper-attachments  
  
EXPOSE 9200 9300  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["elasticsearch"]  

