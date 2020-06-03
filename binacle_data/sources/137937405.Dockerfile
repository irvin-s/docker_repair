FROM bobpace/devbox
MAINTAINER Bob Pace <bob.pace@gmail.com>

#symlinks for dotfiles to be mounted into container via --volumes-from dotfiles
RUN mkdir -p ~/devbox/dotfiles/.vim \
    && ln -s ~/devbox/dotfiles/.vim ~/.vim \
    && mkdir -p ~/devbox/dotfiles/.emacs.d \
    && ln -s ~/devbox/dotfiles/.emacs.d ~/.emacs.d \
    && touch ~/devbox/dotfiles/.vimrc \
    && ln -s ~/devbox/dotfiles/.vimrc ~/.vimrc \
    && touch ~/devbox/dotfiles/.tmux.conf \
    && ln -s ~/devbox/dotfiles/.tmux.conf ~/.tmux.conf \
    && touch ~/devbox/dotfiles/.octaverc \
    && ln -s ~/devbox/dotfiles/.octaverc ~/.octaverc \
    && touch ~/devbox/dotfiles/.curlrc \
    && ln -s ~/devbox/dotfiles/.curlrc ~/.curlrc \
    && touch ~/devbox/dotfiles/.eslintrc \
    && ln -s ~/devbox/dotfiles/.eslintrc ~/.eslintrc \
    && mkdir -p ~/.oh-my-zsh \
    && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && touch ~/devbox/dotfiles/.zshrc \
    && ln -s ~/devbox/dotfiles/.zshrc ~/.zshrc \
    && touch ~/devbox/dotfiles/devbox-scripts.sh \
    && ln -s ~/devbox/dotfiles/devbox-scripts.sh ~/devbox-scripts.sh \
    && touch ~/devbox/dotfiles/.gitconfig \
    && ln -s ~/devbox/dotfiles/.gitconfig ~/.gitconfig

#ForwardAgent yes or ssh -A to pass along ssh keys
#ssh-add -l to see they come through to new containers
RUN mkdir -m 700 ~/.ssh \ 
    && curl -w "\n" https://github.com/bobpace.keys >> ~/.ssh/authorized_keys \
    && sudo chmod 600 /home/devuser/.ssh/authorized_keys

#postgres from vim dbext plugin needs this
RUN touch ~/.pgpass && chmod 600 ~/.pgpass

#fix problem with launching tmux while under a shell that has stty erase = ^H
#without fix can no longer use the control H key binding inside vim or tmux
RUN echo 'stty ek' >> ~/.profile

#grunt-init csharp
RUN mkdir ~/.grunt-init \
  && git clone -b paket \
  https://github.com/bobpace/grunt-init-csharpsolution ~/.grunt-init/csharp \
  && git clone -b paket \
  https://github.com/bobpace/aspnetmvc-for-osx.git ~/.grunt-init/aspnetmvc

VOLUME /home/devuser

CMD ["true"]
