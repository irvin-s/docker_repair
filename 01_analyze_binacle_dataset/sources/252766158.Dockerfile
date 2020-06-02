FROM amaysim/aws:1.1.3  
COPY entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["run"]  

