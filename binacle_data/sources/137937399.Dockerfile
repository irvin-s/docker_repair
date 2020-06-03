FROM bobpace/devbox
MAINTAINER Bob Pace <bob.pace@gmail.com>

RUN rm -rf ~/devbox \
    && git clone https://github.com/bobpace/devbox \
    && git clone https://github.com/Shougo/neobundle.vim ~/devbox/dotfiles/.vim/bundle/neobundle.vim \
    && ln -s ~/devbox/dotfiles/.vimrc ~/.vimrc \
    && ln -s ~/devbox/dotfiles/.vim ~/.vim \
    && ln -s ~/devbox/dotfiles/.emacs.d ~/.emacs.d \
    && ~/devbox/dotfiles/.vim/bundle/neobundle.vim/bin/neoinstall

VOLUME /home/devuser/devbox

CMD ["true"]
