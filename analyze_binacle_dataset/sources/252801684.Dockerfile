FROM ubuntu:16.04  
RUN apt-get update && apt-get -y install\  
vim curl nano iputils-ping  
CMD ["ping", "127.0.0.1", "-c", "10"]  
ENV BATMAN COOL  

