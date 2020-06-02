FROM ubuntu:16.04  
RUN apt-get update;\  
apt-get install -y apt-utils;\  
apt-get dist-upgrade -y;\  
apt-get install -y curl unzip python build-essential git  
  
RUN curl -SLO "https://github.com/laverdet/node/archive/tailcall-backport.zip"  
  
RUN unzip "tailcall-backport.zip"  
  
WORKDIR /node-tailcall-backport  
  
RUN ./configure  
  
RUN make -j 2  
  
RUN make install  
  
WORKDIR /app  
  
RUN npm install screeps@"3.0.0-beta.9"  
  
RUN npm install github:laverdet/isolated-vm  
  
FROM ubuntu:16.04  
WORKDIR /app  
COPY \--from=0 /usr/local /usr/local  
COPY \--from=0 /app .  
  
ADD entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/bin/bash","/entrypoint.sh"]  
CMD ["screeps","start"]  

