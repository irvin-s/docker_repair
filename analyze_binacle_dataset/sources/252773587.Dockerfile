FROM debian:jessie  
  
# mongo and mongod needs libssl.so.10  
RUN apt-get update && apt-get install -y libssl1.0.0 libssl-dev  
RUN cd /lib/x86_64-linux-gnu \  
&& ln -s libssl.so.1.0.0 libssl.so.10 \  
&& ln -s libcrypto.so.1.0.0 libcrypto.so.10 \  
&& ln -s /lib/x86_64-linux-gnu/libssl.so.1.0.0 /usr/lib/libssl.so.10 \  
&& ln -s /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.10  
  
RUN echo "create lab80 user and directories" \  
&& useradd lab80 \  
&& mkdir /data \  
&& chown -R lab80:lab80 /data  
  
USER lab80  
  
RUN echo "copy files"  
COPY forever.sh /usr/local/bin/  
ADD db /data/db  
ADD configdb /data/configdb  
ADD droneio /data/droneio  
ADD jenkins /data/jenkins  
  
VOLUME ["/data"]  
  
ENTRYPOINT ["/usr/local/bin/forever.sh"]  

