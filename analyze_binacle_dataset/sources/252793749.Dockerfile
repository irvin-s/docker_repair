FROM ubuntu:16.04  
USER root  
  
#Speed up in China  
RUN sed -i 's/archive\\.ubuntu/cn.archive.ubuntu/' /etc/apt/sources.list  
RUN apt-get update && \  
apt-get install -y --no-install-recommends apt-utils && \  
apt-get install -y libaio1 && \  
apt-get install -y tzdata  
  
#install python3  
RUN apt-get install -y python3  
  
#install ORACLE instant client  
RUN mkdir /oracle  
WORKDIR /oracle  
  
#NOTE: need to prepare instantclient zip package before build  
ADD instantclient-basic-linux.x64-12.2.0.1.0.zip /oracle  
ADD instantclient-sdk-linux.x64-12.2.0.1.0.zip /oracle  
ADD instantclient-sqlplus-linux.x64-12.2.0.1.0.zip /oracle  
  
RUN apt-get install -y unzip && \  
cd /oracle && \  
unzip instantclient-basic-linux.x64-12.2.0.1.0.zip && \  
unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip && \  
unzip instantclient-sqlplus-linux.x64-12.2.0.1.0.zip  
  
#Environment  
ENV ORACLE_HOME /oracle/instantclient_12_2  
ENV SHLIB_PATH /oracle/instantclient_12_2  
ENV LD_LIBRARY_PATH /oracle/instantclient_12_2  
ENV NLS_LANG american_america.zhs16gbk  
ENV NLS_DATE_FORMAT 'YYYY-MM-DD HH24:MI:SS'  
ENV TZ 'Asia/Shanghai'  

