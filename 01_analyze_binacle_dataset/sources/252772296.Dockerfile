FROM docker.io/avatao/ubuntu:16.04  
  
ENV SECRET=test FLAG=flag CONTROLLER_PORT=5555 SOLVABLE_PORT=8888  
  
EXPOSE 2222 5555 8888  
  
USER user  
  
COPY entrypoint.sh server.py /opt/  
  
CMD ["/opt/entrypoint.sh"]  

