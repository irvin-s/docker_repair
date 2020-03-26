from ubuntu:14.04

run apt-get update
run apt-get -qy install curl git-core build-essential python libfontconfig
run curl -fs https://raw.githubusercontent.com/mafintosh/node-install/master/install | sh
run node-install 0.10.32
run npm config set color always

workdir /root

add package.json /root/
run npm install --loglevel http --unsafe-perm 2>&1
add . /root/

entrypoint ["node", "index.js"]
