FROM alpine:3.3  
MAINTAINER Dylan Sides  
  
ADD rootfs /  
  
#RUN apk update && \  
# apk upgrade && \  
# apk add \  
# ca-certificates \  
# curl \  
# bash \  
# bash-completion \  
# ncurses \  
# vim \  
# gettext \  
# tar \  
# rsync \  
# ansible \  
# nano \  
# openssh-client \  
# nodejs \  
# ncdu \  
# git \  
# git-bash-completion \  
# dnstop \  
# mosh-client \  
# nload \  
# iftop \  
# lynx \  
# mtr \  
# tmux \  
# tmux-bash-completion \  
# wget \  
# nmap \  
# curl \  
# wireshark \  
# bzip2 \  
# dnsmaq \  
# tig \  
# htop \  
# links \  
# Combine into a single line later to prevent caching of apk update.  
# Individual RUN commands are useful to inspect the footprint of packages  
RUN apk update  
RUN apk upgrade  
  
RUN apk add ca-certificates  
RUN apk add curl  
RUN apk add bash  
RUN apk add bash-completion  
RUN apk add ncurses  
RUN apk add vim  
RUN apk add tar  
RUN apk add rsync  
RUN apk add ansible  
RUN apk add nano  
RUN apk add openssh-client  
RUN apk add nodejs  
RUN apk add ncdu  
RUN apk add git  
RUN apk add git-bash-completion  
RUN apk add dnstop  
RUN apk add nload  
RUN apk add iftop  
RUN apk add lynx  
RUN apk add mtr  
RUN apk add wget  
RUN apk add nmap  
RUN apk add curl  
RUN apk add bzip2  
RUN apk add dnsmasq  
RUN apk add tig  
RUN apk add htop  
RUN apk add links  
RUN apk add fish  
  
RUN rm -rf /var/cache/apk/*  
  
CMD ["bash"]

