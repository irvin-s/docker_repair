FROM ubuntu:latest
# https://github.com/zcash/zcash/wiki/Debian-binary-packages
RUN apt-get update ; apt-get install -y apt-transport-https wget apt-utils ;\
    wget -qO - https://apt.z.cash/zcash.asc | apt-key add - ;\
    echo "deb [arch=amd64] https://apt.z.cash/ jessie main" | tee /etc/apt/sources.list.d/zcash.list ;\
    apt-get update ; apt-get install -y zcash
RUN zcash-fetch-params
ADD zcash.conf /root/.zcash/
