FROM alpine  
  
# Copy source files  
COPY ./src /src  
  
# Copy scripts  
COPY ./scripts /home  
RUN chmod +x /home/*  
RUN /home/init_scripts.sh  
  
ENTRYPOINT ["/home/install_laravel_project.sh"]

