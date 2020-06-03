FROM channelit/attzksolr  
RUN \  
cd /usr/local &&\  
mkdir fusion &&\  
cd fusion &&\  
wget https://download.lucidworks.com/fusion-2.2.0.tar.gz &&\  
tar xzvf fusion-2.2.0.tar.gz &&\  
cd fusion/bin &&\  
rm ../conf/config.sh &&\  
mv /fconfig.sh ../conf/config.sh  

