FROM aphistic/rust-build:stable-linux  
  
COPY run.sh /  
  
ENTRYPOINT ["/run.sh"]  

