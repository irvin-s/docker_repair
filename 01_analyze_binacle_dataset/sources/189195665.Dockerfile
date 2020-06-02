#BUILD_PUSH=hub,quay
FROM bigm/base-deb

# don't be ascetic
RUN /xt/tools/_install_admin_tools full

## zsh & prezto installation without the need to install git
#WORKDIR /tmp
#RUN /xt/tools/_apt_install zsh \
#  && git clone --recursive https://github.com/sorin-ionescu/prezto.git zprezto \
#  && wget https://raw.githubusercontent.com/Kentzo/git-archive-all/master/git_archive_all.py \
#  && mv /tmp/git_archive_all.py /tmp/git-archive-all && chmod +x /tmp/git-archive-all \
#  && cd /tmp/zprezto \
#  && /tmp/git-archive-all /tmp/zprezto.tar.bz2 \
#  && tar -xf /tmp/zprezto.tar.bz2 \
#  && mv /tmp/zprezto /root/.zprezto \
#  && rm -fr /tmp/zprezto /tmp/zprezto.tar.bz2 /tmp/git-archive-all \
#  && zsh -c 'setopt EXTENDED_GLOB && for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

# use zsh & prezto & git
RUN /xt/tools/_apt_install zsh-static git \
    && git clone --recursive https://github.com/sorin-ionescu/prezto.git /root/.zprezto \
    && chsh -s /bin/zsh
ADD root/ /

# add termite terminfo
RUN /xt/tools/_download /tmp/termite.terminfo https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo \
    && tic /tmp/termite.terminfo \
    && rm /tmp/termite.terminfo

RUN /xt/tools/_apt_install ncdu
