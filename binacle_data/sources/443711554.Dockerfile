FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN apt-get install -y python-setuptools
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y zip
RUN apt-get install -y openssl
RUN apt-get install -y git
RUN apt-get install -y emacs24
RUN apt-get install -y tmux
RUN apt-get install -y ack-grep
RUN apt-get install -y python
RUN apt-get install -y wget
RUN apt-get install -y xsel
RUN apt-get install -y python-pip
RUN apt-get install -y zsh
RUN apt-get install -y curl
RUN apt-get install -y build-essential
RUN apt-get install -y runit
RUN apt-get install -y openssh-server
RUN apt-get install -y ruby
RUN apt-get install -y tree
RUN apt-get install -y vim
RUN apt-get install -y libevent-dev
RUN apt-get install -y ncurses-dev
RUN apt-get install -y rake

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get -y install oracle-java7-installer

RUN easy_install httpie
RUN pip install https://github.com/Lokaltog/powerline/tarball/develop

# Tmux
RUN wget http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz
RUN tar -zxf tmux-1.9a.tar.gz
RUN cd tmux-1.9a && ./configure && make install
RUN rm -r /tmux-1.9a*
RUN pip install --upgrade --user git+git://github.com/Lokaltog/powerline

RUN useradd -s /bin/zsh -m -d /home/pairing -g root pairing
RUN echo "pairing:pairing" | chpasswd
RUN echo "pairing        ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER pairing
ENV HOME /home/pairing
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git /home/pairing/.oh-my-zsh
RUN chown -R pairing /home/pairing/.oh-my-zsh

RUN git clone https://github.com/adnichols/tmux-and-vim.git /home/pairing/.janus
RUN bash -l -c /home/pairing/.janus/setup/setup.sh
# Fixup powerline for this setup
RUN sed -i 's%/usr/local/lib/python2\.7/site-packages%/usr/local/lib/python2.7/dist-packages%' ~/.tmux.conf
ADD resources/zshrc.default /home/pairing/.zshrc
RUN mkdir /home/pairing/projects

USER root

# Runit setup
RUN mkdir -p /etc/service
ADD runit-ssh /etc/service/ssh
ADD runit /etc/runit

RUN mkdir -p /var/run/sshd

EXPOSE 22

CMD /usr/sbin/sshd -D -o UsePAM=no
