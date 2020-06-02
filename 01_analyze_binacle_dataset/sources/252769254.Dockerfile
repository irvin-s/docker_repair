FROM anibali/alpine-tini:3.2  
RUN apk add --update curl git go \  
&& mkdir -p /usr/src/etcd \  
&& git clone https://github.com/coreos/etcd.git /usr/src/etcd \  
&& cd /usr/src/etcd \  
&& git checkout tags/v2.2.1 \  
&& ./build \  
&& cp /usr/src/etcd/bin/* /usr/bin \  
&& rm -rf /usr/src/etcd \  
&& apk del curl git go \  
&& rm -rf /var/cache/apk/*  
  
COPY start_etcd.sh /  
  
EXPOSE 2379  
EXPOSE 2380  
CMD ["/start_etcd.sh"]  

