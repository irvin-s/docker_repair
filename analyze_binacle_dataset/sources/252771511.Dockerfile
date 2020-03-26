from debian:jessie  
maintainer rickard@gimerstedt.se  
  
env SHELL=/usr/bin/zsh  
  
run apt-get update  
run apt-get install -y zsh vim git python curl  
run apt-get install locales  
  
run echo "en_US.UTF-8 UTF-8" | tee -a /etc/locale.gen  
run locale-gen  
  
# get dotfiles  
run git clone https://github.com/gimerstedt/dotfiles.git /root/git/dotfiles  
run cd /root/git/dotfiles && sh /root/git/dotfiles/install.sh  
  
# clean up  
run apt-get clean  
run rm -rf /var/lib/apt/lists/*  
  
workdir /root  
cmd ["/usr/bin/zsh"]  

