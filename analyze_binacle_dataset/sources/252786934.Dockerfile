FROM dorftv/codem-transcode  
  
COPY codem.json /etc/codem.json  
  
EXPOSE 80  
CMD ["codem-transcode", "-c", "/etc/codem.json"]  

