FROM tutum/lamp:latest  
VOLUME ["/app"]  
EXPOSE 80 3306  
CMD ["/run.sh"]  

