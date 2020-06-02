FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install libboost-filesystem-dev build-essential curl -y
RUN apt-get install npm p7zip-full redis-server rabbitmq-server mysql-client -y
RUN npm install -g n
RUN n lts
RUN mkdir /var/syzoj && mkdir /mnt/syzoj-bin && mkdir /etc/syzoj-config && mkdir /mnt/syzoj-tmp1 && mkdir /mnt/syzoj-tmp2 && mkdir /mnt/syzoj-data
ADD syzoj.tar.xz /var/syzoj/syzoj/
ADD judge-v3.tar.xz /var/syzoj/judge-v3/
WORKDIR /var/syzoj/syzoj
RUN npm install
WORKDIR /var/syzoj/judge-v3
RUN npm install
RUN npm install syspipe
RUN npm run-script build
ADD config/* /etc/syzoj-config/
WORKDIR /root
ADD scripts/* /root/
EXPOSE 5283
CMD ["/bin/bash", "/root/start.sh"]
