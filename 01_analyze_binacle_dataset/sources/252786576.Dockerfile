FROM alpine  
  
COPY ./scripts /  
RUN /install.sh && rm /install*  
  
VOLUME ["/cssapp"]  
WORKDIR /cssapp  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["compass"]  

