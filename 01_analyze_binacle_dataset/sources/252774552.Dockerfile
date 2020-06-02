FROM barkingiguana/hadoop-base  
  
MAINTAINER Craig R Webster <craig@barkingiguana.com>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq hadoop-hdfs-namenode  
RUN mkdir -p /data/1/dfs/nn  
ADD hdfs-site.xml /etc/hadoop/conf.barkingiguana/hdfs-site.xml  
RUN sudo -u hdfs hdfs namenode -format  

