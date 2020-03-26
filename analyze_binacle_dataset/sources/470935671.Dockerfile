FROM node:latest
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get install -y sudo git nano wget curl ntp build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev git npm nodejs nodejs-legacy libminiupnpc-dev redis-server software-properties-common fail2ban


RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install libdb4.8-dev libdb4.8++-dev
RUN systemctl enable redis-server
RUN systemctl start redis-server
RUN systemctl enable fail2ban
RUN systemctl start fail2ban
RUN systemctl enable ntp
RUN systemctl start ntp
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN source ~/.bashrc
RUN nvm install v8.1.4
RUN nvm use v8.1.4
RUN npm update -g
RUN npm install -g pm2@latest
RUN npm install -g npm@latest
RUN pm2 init



WORKDIR /opt/
RUN git clone https://github.com/leshacat/EasyNOMP.git

WORKDIR /opt/EasyNOMP

RUN npm install -g multi-hashing@latest
RUN npm install
RUN npm update
RUN npm audit fix

RUN rm config_example.json
RUN rm -rf coins
RUN rm -rf pool_configs
RUN ln -s /opt/config/config.json /opt/BootNOMP/config.json
RUN ln -s /opt/config/coins /opt/BootNOMP/coins
RUN ln -s /opt/config/pool_configs /opt/BootNOMP/pool_configs

CMD service redis-server restart; service fail2ban restart; service ntp restart; pm2 start init.js -i max --watch --name pool
