FROM dclong/python  
  
RUN pip3 install bokeh  
  
EXPOSE 5006  
COPY scripts /scripts  
COPY app /app  
  
ENTRYPOINT ["/scripts/init.sh"]  

