FROM alpine:3.6  
RUN apk add --no-cache tftp-hpa  
  
COPY launch.sh /launch.sh  
RUN chmod +x /launch.sh  
  
VOLUME /var/tftpboot  
  
EXPOSE 69/udp  
  
ENTRYPOINT ["/launch.sh"]  
  
CMD ["--verbosity", "6"]

