FROM bigm/base-deb-tools

# some inspirations:
## https://github.com/docker-in-practice/docker-dev-tools-image/blob/master/Dockerfile

RUN /xt/tools/_enable_ssmtp \
  && /xt/tools/_apt_install heirloom-mailx \
  net-tools nmap subversion whois socat openssh-client \
  iotop strace tcpdump iproute ltrace lsof inotify-tools sysstat ddd tmux \
  jq telnet sshfs tree screen zip unzip rsync patch sed mssh
