FROM ubuntu:15.10

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  -qq
RUN apt-get upgrade -qq

RUN apt-get install -qy haskell-platform=2014.2.0.0.debian2
RUN apt-get install -qy git
RUN apt-get install -qy emacs

# --------------------------------------------------------
# Installing make
# --------------------------------------------------------
RUN apt-get install -qy build-essential
RUN apt-get install -qy texinfo
RUN apt-get install -qy install-info
RUN apt-get install -qy sudo

# --------------------------------------------------------
# Setting up x11 forwarding (taken from Fábio Rehm's blog)
# --------------------------------------------------------
# replace "1000" below with proper uid and gid
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

# ---------------------------------------------
# Installing haskell-mode for Emacs
# ---------------------------------------------
RUN cd /home/developer && \
    git clone https://github.com/haskell/haskell-mode.git
RUN cd /home/developer/haskell-mode && \
    make EMACS=/usr/bin/emacs
RUN echo "(add-to-list 'load-path \"/home/developer/haskell-mode/\")" >> /home/developer/.emacs
RUN echo "(require 'haskell-mode-autoloads)" >> /home/developer/.emacs
RUN echo "(add-to-list 'Info-default-directory-list \"/home/developer/haskell-mode/\")" >> /home/developer/.emacs
RUN echo "(require 'haskell-interactive-mode)" >> /home/developer/.emacs
RUN echo "(require 'haskell-process)" >> /home/developer/.emacs
RUN echo "(add-hook 'haskell-mode-hook 'interactive-haskell-mode)" >> /home/developer/.emacs
RUN echo "(setq x-select-enable-clipboard t)" >> /home/developer/.emacs
RUN echo "(tool-bar-mode -1)" >> /home/developer/.emacs
RUN echo "(setq inhibit-startup-screen t)" >> /home/developer/.emacs
RUN echo "(kill-buffer \"*scratch*\")" >> /home/developer/.emacs

# ---------------------------------------------
# Installing QFeldspar
# ---------------------------------------------
RUN cd /home/developer && \
    git clone https://github.com/shayan-najd/QFeldspar.git
RUN cd /home/developer/QFeldspar/ && \
    cabal update        && \
    cabal install       && \
    ./setpermissions

CMD /bin/bash