FROM debian  
RUN apt-get update && apt-get install -y \  
tcpdump  
RUN mkdir /pcap  
RUN cd /pcap  
WORKDIR /pcap  
CMD tcpdump -G 900 -w '%Y-%m-%d_%H:%M:%S.pcap' -W 96  

