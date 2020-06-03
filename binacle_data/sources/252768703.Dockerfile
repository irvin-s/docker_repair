FROM alpine:3.6  
  
RUN apk --no-cache add ucspi-tcp6 fortune  
ADD fortune_wrapper.sh /srv/  
EXPOSE 8080  
USER nobody  
CMD ["tcpserver", "-vH", "0.0.0.0", "8080", "/srv/fortune_wrapper.sh"]  

