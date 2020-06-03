FROM mysql:latest  
ENV WARTEZEIT=15  
COPY assets/lazy_entrypoint.sh /  
ENTRYPOINT ["/lazy_entrypoint.sh"]  
CMD ["mysqld"]  

