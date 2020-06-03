FROM concretesolutions/python-dev  
  
# Install Django  
RUN pip install Django && mkdir -p /var/www  
WORKDIR /var/www  
  
# Copy startup script  
COPY /var/init/run.sh /var/init/run.sh  
RUN chmod +x /var/init/run.sh  
  
USER dev  
  
EXPOSE 8000  
CMD ["bash", "/var/init/run.sh"]  

