FROM ubuntu:16.04  
MAINTAINER cd <cleardevice@gmail.com>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \  
apt-get install -y nano git make g++ autoconf && \  
\  
git clone https://github.com/ideawu/ssdb.git /tmp/ssdb --depth 1 && \  
cd /tmp/ssdb && make && make install && \  
mv /usr/local/ssdb /ssdb && \  
\  
apt-get remove \--purge -y git make g++ autoconf && \  
apt-get autoremove -y && \  
apt-get clean -y && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
\  
mkdir -p /ssdb/conf /ssdb/data && \  
cp /ssdb/ssdb.conf /ssdb/conf && \  
sed \  
-e 's@work_dir = .*@work_dir = /ssdb/data@' \  
-e 's@pidfile = .*@pidfile = /run/ssdb.pid@' \  
-e 's@level:.*@level: info@' \  
-e 's@output:.*@output: stdout@' \  
-e 's@ip:.*@ip: 0.0.0.0@' \  
-i /ssdb/conf/ssdb.conf  
  
WORKDIR /ssdb  
VOLUME /ssdb/data  
  
EXPOSE 8888  
  
CMD /ssdb/ssdb-server /ssdb/conf/ssdb.conf  

