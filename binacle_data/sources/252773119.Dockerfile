FROM ehazlett/interlock:multihost  
ADD entrypoint /usr/local/bin/entrypoint  
ENTRYPOINT ["/usr/local/bin/entrypoint"]  

