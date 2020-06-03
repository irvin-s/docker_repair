FROM hashicorp/packer  
  
RUN apk add --update qemu qemu-system-x86_64 qemu-img  
RUN find / -iname '*qemu*'  
  
ENV PACKER_LOG=1  
ENTRYPOINT ["/bin/packer"]  

