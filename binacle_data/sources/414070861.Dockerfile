from ubuntu:12.04

run apt-get -y update
run apt-get -y install wget
run wget -O - http://nodejs.org/dist/v0.8.26/node-v0.8.26-linux-x64.tar.gz | tar -C /usr/local/ --strip-components=1 -zxv
expose 3000

add . /opt/dongsa
run rm -rf /opt/dongsa/node_modules
run cd /opt/dongsa && npm install

workdir /opt/dongsa
cmd ["node", "server.js"]
