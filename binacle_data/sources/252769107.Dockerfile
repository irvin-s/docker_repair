FROM alpine:3.6  
LABEL com.nvidia.volumes.needed="nvidia_driver"  
  
CMD ls /usr/local/nvidia/bin  

