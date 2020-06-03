FROM dcflachs/clamav  
  
VOLUME /malware  
  
WORKDIR /  
  
COPY scan.sh /scan.sh  
RUN chmod +x /scan.sh  
  
RUN apk add --no-cache curl  
  
ENTRYPOINT ["/scan.sh", "--max-filesize=4000M", "-r"]  
  
CMD ["/malware"]

