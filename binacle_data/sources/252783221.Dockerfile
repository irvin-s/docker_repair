FROM dclong/python  
  
RUN pip3 install \  
Flask \  
Flask-Bootstrap \  
pandas  
  
EXPOSE 80  
EXPOSE 5000  
ADD script.sh /  
  
ENTRYPOINT ["/init.sh"]  

