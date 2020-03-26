FROM maxcnunes/unrar  
  
RUN mkdir -p /config  
COPY cmd/* /cmd/  
CMD ["/bin/sh", "/cmd/cycle.sh"]  

