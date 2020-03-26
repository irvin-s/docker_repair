FROM kibana  
  
COPY ./init_app.sh /root/init_app.sh  
  
ENTRYPOINT ["/root/init_app.sh"]  

