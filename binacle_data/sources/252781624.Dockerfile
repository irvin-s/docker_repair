FROM barkingiguana/hadoop-base  
  
MAINTAINER Craig R Webster <craig@barkingiguana.com>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq hadoop-client  

