FROM brimstone/ubuntu:14.04  
RUN apt-get update \  
&& apt -y install iperf \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists  
  
ENTRYPOINT ["iperf"]  
  
CMD ["-s"]  
  
EXPOSE 5001 5001/udp  

