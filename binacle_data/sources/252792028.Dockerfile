FROM ubuntu:trusty  
MAINTAINER Chris Hardekopf <chrish@basis.com>  
  
# Install packages:  
# editor(s), tools for getting files, version control  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y nano vim emacs24-nox \  
curl wget openssh-client ncftp lftp rsync \  
git git-svn subversion apache2-utils tmux && \  
rm -rf /var/lib/apt/lists/*  

