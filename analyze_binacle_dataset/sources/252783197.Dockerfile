FROM dcflachs/clamav  
  
WORKDIR /  
  
ENTRYPOINT ["/usr/bin/freshclam"]

