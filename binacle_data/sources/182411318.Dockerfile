FROM ubuntu:18.04
MAINTAINER Don Petersen <don@donpetersen.net>

# Start by changing the apt output, as stolen from Discourse's Dockerfiles.
RUN echo "debconf debconf/frontend select Teletype" | debconf-set-selections &&\
# Probably a good idea
    apt-get update &&\
# Nobody is happy when these aren't up-to-date
    apt-get install -y ca-certificates &&\
# Basic dev tools
    apt-get install -y openssh-client git build-essential ctags man curl direnv software-properties-common &&\
# Set up for pairing with wemux.
    apt-get install -y tmux &&\
    git clone git://github.com/zolrath/wemux.git /usr/local/share/wemux &&\
    ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux &&\
    cp /usr/local/share/wemux/wemux.conf.example /usr/local/etc/wemux.conf &&\
    echo "host_list=(dev)" >> /usr/local/etc/wemux.conf &&\
# Install neovim
    apt-get install -y neovim &&\
# Install Homesick, through which zsh and vim configurations will be installed
    apt-get install -y ruby &&\
    gem install homesick --no-document &&\
# Install the Github Auth gem, which will be used to get SSH keys from GitHub
# to authorize users for SSH
    gem install github-auth --no-document &&\
# Install zsh
    apt-get install -y zsh &&\
# Install searching tools
    apt-get install -y ack-grep &&\
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb && \
    dpkg -i ripgrep_0.10.0_amd64.deb && \
    rm ripgrep_0.10.0_amd64.deb && \
# Set up SSH. We set up SSH forwarding so that transactions like git pushes
# from the container happen magically.
    apt-get install -y openssh-server &&\
    mkdir /var/run/sshd &&\
    echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config &&\
# Install fzf
    wget https://github.com/junegunn/fzf-bin/releases/download/0.17.4/fzf-0.17.4-linux_amd64.tgz && \
    tar -zxvf fzf-0.17.4-linux_amd64.tgz && \
    mv fzf /usr/local/bin/fzf && \
    rm fzf-0.17.4-linux_amd64.tgz && \
# Install exa
    wget https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip && \
    unzip exa-linux-x86_64-0.8.0.zip && \
    mv exa-linux-x86_64 /usr/local/bin/exa && \
    rm exa-linux-x86_64-0.8.0.zip && \
# Fix for occasional errors in perl stuff (git, ack) saying that locale vars
# aren't set.
    apt-get install -y locales &&\
    locale-gen --purge en_US.UTF-8 &&\
    update-locale LANG=en_US.UTF-8

RUN apt-get install -y sudo && \
    useradd dev -d /home/dev -m -s /bin/zsh &&\
    adduser dev sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dev

ADD ssh_key_adder.rb /home/dev/ssh_key_adder.rb

RUN \
# Set up shell
    homesick clone dpetersen/zshfiles &&\
    homesick symlink zshfiles &&\
# Set up The Editor of the Gods
    homesick clone dpetersen/vimfiles &&\
    homesick symlink vimfiles && \
    vim +PlugInstall +qall

# Expose SSH
EXPOSE 22

# Install the SSH keys of ENV-configured GitHub users before running the SSH
# server process. See README for SSH instructions.
CMD /home/dev/ssh_key_adder.rb && sudo /usr/sbin/sshd -D
