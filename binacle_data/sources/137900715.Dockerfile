from ubuntu:12.10
maintainer Justin Gallardo <justin.gallardo@gmail.com>

run echo "deb http://archive.ubuntu.com/ubuntu quantal main universe" > /etc/apt/sources.list
run apt-get update
run apt-get upgrade -y

run apt-get install curl wget -y
run apt-get install supervisor -y
run apt-get install openssh-server -y
run apt-get install make build-essential -y
run apt-get install python python-dev -y

run mkdir -p /var/run/sshd
run mkdir -p /var/log/supervisor
run locale-gen en_US en_US.UTF-8

run echo 'root:badpass' | chpasswd


run apt-get install git vim -y

run curl https://raw.github.com/isaacs/nave/master/nave.sh > /bin/nave && chmod a+x /bin/nave
run nave usemain stable

run apt-get install redis-server -y

run git clone https://github.com/jirwin/treslek.git /opt/treslek
run cd /opt/treslek && npm install
run apt-get install figlet

add supervisord.conf /etc/supervisor/conf.d/supervisord.conf

add conf.js /opt/treslek/conf.js

cmd ["/usr/bin/supervisord", "-n"]

expose 22 6379
