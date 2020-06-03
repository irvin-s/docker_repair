FROM ubuntu:14.04  
CMD ["bash", "-c", "read -t 1 stdin; echo $stdin"]  

