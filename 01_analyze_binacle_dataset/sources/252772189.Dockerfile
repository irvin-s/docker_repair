from debian:jessie  
run \  
apt-get update &&\  
apt-get install -y build-essential git zlib1g-dev libssl-dev &&\  
cd /tmp &&\  
git clone https://github.com/xroche/httrack.git --recurse --depth=1 &&\  
cd httrack &&\  
./configure --prefix="/usr" &&\  
make -j8 &&\  
make install &&\  
cd / &&\  
rm -rf /tmp/httrack &&\  
apt-get remove -y --purge build-essential git zlib1g-dev libssl-dev &&\  
apt-get autoremove -y &&\  
apt-get clean  
run mkdir /mirror  
workdir /mirror  
cmd httrack  
  

