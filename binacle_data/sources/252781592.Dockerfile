FROM barbudo/python  
  
ADD . /w3af  
RUN /w3af/install.sh  
  
RUN mv /w3af/w3af /home/app/.w3af && chown -R app /home/app/.w3af  
USER app  
WORKDIR /home/app/w3af  
  
ENTRYPOINT ["./w3af_console"]

