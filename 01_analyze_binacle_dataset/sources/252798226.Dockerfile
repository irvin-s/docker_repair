FROM debian:sid  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get dist-upgrade -y \  
&& apt-get clean  
  
RUN apt-get update \  
&& apt-get install -y locales sudo \  
&& apt-get clean  
ADD locale.gen /etc/locale.gen  
RUN /usr/sbin/locale-gen  
  
RUN apt-get update \  
&& apt-get install -y \  
build-essential \  
byobu \  
bzr \  
ca-certificates \  
curl \  
git \  
man \  
mercurial \  
openssh-server \  
openssl \  
software-properties-common \  
subversion \  
time \  
vim \  
vim-addon-manager \  
vim-nox \  
vim-scripts \  
vim-syntax-docker \  
zsh \  
&& apt-get clean \  
&& mkdir /var/run/sshd  
  
RUN adduser --disabled-login --gecos "Pierre D'eau,,," pierre \  
&& adduser pierre sudo  
  
ADD sshd_config /etc/ssh/sshd_config  
ADD sudoers /etc/sudoers  
ADD gitconfig /home/pierre/.gitconfig  
ADD vimrc /home/pierre/.vimrc  
ADD set-git-user /usr/local/bin/set-git-user  
  
RUN chmod 755 /usr/local/bin/set-git-user \  
&& chmod 440 /etc/sudoers \  
&& chown -R pierre:pierre /home/pierre  
  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D"]  

