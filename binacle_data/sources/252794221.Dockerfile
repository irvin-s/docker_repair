FROM bash:latest  
RUN apk update && \  
apk add git && \  
git clone https://github.com/sstephenson/bats.git && \  
cd bats && \  
./install.sh /usr/local && \  
cd .. && \  
rm -r bats && \  
apk del git && \  
rm /var/cache/apk/*

