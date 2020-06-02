# Base image used is Ubuntu 12.04:
FROM ubuntu:precise
MAINTAINER C. W. Drake, cameron@drake.fm

RUN apt-get update -y
RUN apt-get -y upgrade
RUN apt-get upgrade --show-upgraded
RUN apt-get install -y zsh
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y emacs
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y tig
RUN apt-get install -y htop
RUN apt-get install -y tree
RUN apt-get install -y wget
RUN apt-get install -y tmux
RUN apt-get install -y rubygems
RUN apt-get install -y unzip
RUN apt-get install -y ntp
RUN apt-get install -y fail2ban
# Install Mosh
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:keithw/mosh
RUN apt-get update
RUN apt-get install -y mosh
# Install hub for git
# RUN git clone https://github.com/github/hub.git
# RUN cd hub
# RUN rake install prefix=/usr/local
# RUN cd -
#-------------------
# Install Ruby Gems
#-------------------
RUN gem install bundler
RUN bundle install
#-------------------
# Create Git User
#-------------------
RUN adduser --disabled-password --gecos "" git
RUN usermod -a -G sudo git
#-------------------
# Start Clock
#-------------------
# Configure Time Zone
# RUN dpkg-reconfigure tzdata
# RUN ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
# Set clock/restart cron
# RUN ntpdate && hwclock –w
# RUN service cron stop
# RUN service cron start
#-------------------
# Sync Dotfiles
#-------------------
# change the default shell for git user
# RUN chsh -s /usr/bin/zsh core
# move the AWS authorized key to the git account
# RUN mkdir -p /home/git/.ssh/
# RUN cp -i /home/core/.ssh/authorized_keys /home/git/.ssh/authorized_keys
# sync dotfiles
ADD ./dotfiles ~/dotfiles
# RUN rsync --exclude ".git/"  --exclude ".osx" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av --no-perms ~/dotfiles ~
# sudo chmod a+rx /home/git
# sudo chown -R git:git /home/git/
# CMD ["/bin/zsh", "-l"]
# ENTRYPOINT ["/bin/zsh", "-l"]