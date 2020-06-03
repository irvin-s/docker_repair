FROM tianon/ubuntu-core:14.04

# Initial Setup, Basic Package Installs
RUN DEBIAN_FRONTEND=noninteractive; apt-get update; apt-get upgrade -y; apt-get install --no-install-recommends -y vim-nox make zsh golang-go gcc tmux git mercurial cmake python-dev openssh-client wget curl docker.io; apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Other Installs
RUN mkdir -p /home/treed/bin/
ADD http://stedolan.github.io/jq/download/linux64/jq /home/treed/bin/
RUN chmod +x /home/treed/bin/jq

# Install Basic Configs
WORKDIR /home/treed
ENV HOME /home/treed
ADD tmux.conf /home/treed/.tmux.conf
ADD cvsignore /home/treed/.cvsignore
ADD shellrc /home/treed/.shellrc
ADD gitconfig /home/treed/.gitconfig
ADD zshrc /home/treed/.zshrc
ADD vim /home/treed/.vim
ADD oh-my-zsh /home/treed/.oh-my-zsh
ADD oh-my-zsh-custom /home/treed/.oh-my-zsh-custom

# Bootstrap vim
ADD vimrc-plugins .vimrc
RUN vim +PlugInstall +qa
RUN mv .vimrc .vimrc-plugins
ADD vimrc .vimrc

# Handle User
RUN adduser --disabled-password -u 500 treed
RUN chown -R treed:treed /home/treed
RUN echo 'treed ALL=NOPASSWD: ALL' >> /etc/sudoers
USER treed

VOLUME /home/treed/code
VOLUME /home/treed/.ssh

ENV TZ America/Los_Angeles

ENTRYPOINT ["zsh"]
