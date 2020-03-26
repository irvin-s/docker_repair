FROM alljoynsville/iotivity-base  
  
RUN cd /home/builder/iotivity && ./auto_build.sh linux_unsecured  

