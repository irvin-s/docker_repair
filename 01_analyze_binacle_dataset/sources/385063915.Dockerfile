from ubuntu:14.04

run apt-get update -y
run apt-get install -y mercurial
run apt-get install -y git
run apt-get install -y bzr
run apt-get install -y python
run apt-get install -y httpie
run apt-get install -y curl
run apt-get install -y vim
run apt-get install -y strace
run apt-get install -y diffstat
run apt-get install -y build-essential
run apt-get install -y tcpdump
run apt-get install -y tmux
run apt-get install -y zsh
run apt-get install -y python-pip
run pip install virtualenv
run apt-get install -y virtualenvwrapper

# Install go
run curl https://storage.googleapis.com/golang/go1.3beta2.linux-amd64.tar.gz | tar -C /usr/local -zx
env GOROOT /usr/local/go
env PATH /usr/local/go/bin:$PATH

# Setup home environment
run useradd dev
run mkdir /home/dev && chown -R dev: /home/dev
run mkdir -p /home/dev/go /home/dev/bin /home/dev/lib /home/dev/include
env PATH /home/dev/bin:$PATH
env PKG_CONFIG_PATH /home/dev/lib/pkgconfig
env LD_LIBRARY_PATH /home/dev/lib
env GOPATH /home/dev/go

run mkdir /var/shared/
run touch /var/shared/placeholder
run chown -R dev:dev /var/shared
volume /var/shared

workdir /home/dev
env HOME /home/dev
add . /home/dev/dotfiles
run make -C /home/dev/dotfiles dockerenv
run ln -s /var/shared/.ssh

run chown -R dev: /home/dev
user dev

entrypoint ["/bin/zsh", "-l"]
