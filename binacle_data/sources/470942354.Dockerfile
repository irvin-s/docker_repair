from ubuntu:16.04
maintainer Mike Taghavi <mitghi@me.com>

env DEBIAN_FRONTEND noninteractive

arg GODLURL=https://storage.googleapis.com/golang/go1.8.1.linux-amd64.tar.gz
arg PROTOX_SRC=github.com/mitghi/protox
arg PROTOX_GIT_ADDR=git@github.com:mitghi/protox.git
arg USRNAME=dev
arg GIT_HOST=github.com
arg GIT_LOCAL_KEY=id_rsa_depl
arg GO_GIT_ROOT=mitghi

env GOROOT /usr/local/go
env HOME /home/$USRNAME
env PKG_CONFIG_PATH $HOME/lib/pkgconfig
env LD_LIBRARY_PATH $HOME/lib
env GOPATH $HOME/go

run dpkg --configure -a
run apt-get update -y
run apt-get upgrade -y
run apt-get autoremove -y
run apt-get clean
run apt-get install -y --no-install-recommends apt-utils
run apt-get install -y curl
run apt-get install -y pkg-config
run apt-get install -y build-essential
run apt-get install -y zip
run apt-get install -y unzip
run apt-get install -y git
run apt-get install -y make
run apt-get install -y sudo
run apt-get install -y ssh
run rm -rf /var/lib/apt-get/lists/*

run curl $GODLURL | tar -C /usr/local -zx
env PATH /usr/local/go/bin:$PATH

run useradd $USRNAME
run mkdir $HOME && chown -R $USRNAME: $HOME
run mkdir -p $HOME/go $HOME/bin $HOME/lib $HOME/include $HOME/go/bin $HOME/go/src
env PATH $HOME/bin:$PATH
env PATH $HOME/go/bin:$PATH

run mkdir /var/shared/
run touch /var/shared/placeholder
run chown -R $USRNAME: /var/shared
#run echo "$USRNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

volume /var/shared
workdir /home/dev

run ln -s /var/shared/.bash_history
run ln -s /var/shared/.maintainercfg

run mkdir -p $HOME/.ssh
run mkdir -p $HOME/go/src/$GIT_HOST/$GO_GIT_ROOT
run chown -R dev: $HOME
add $GIT_LOCAL_KEY $HOME/.ssh/id_rsa
run chmod -R 700 $HOME/.ssh && chmod 600 $HOME/.ssh/id_rsa
run chown -R dev:dev $HOME

user $USRNAME
run touch $HOME/.ssh/known_hosts
run ssh-keyscan $GIT_HOST >> $HOME/.ssh/known_hosts
run git clone $PROTOX_GIT_ADDR $GOPATH/src/$PROTOX_SRC
workdir $GOPATH
run go get ./...
run go install -v $PROTOX_SRC && cp $GOPATH/bin/protox /var/shared

# 0xcead
expose 52909
entrypoint protox
