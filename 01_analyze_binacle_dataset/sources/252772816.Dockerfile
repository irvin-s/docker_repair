FROM ubuntu  
RUN apt update  
RUN apt install -y netcat net-tools iputils-ping dnsutils socat  
ENTRYPOINT ["sleep", "1000000"]  

