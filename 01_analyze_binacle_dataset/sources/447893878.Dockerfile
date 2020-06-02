FROM ubuntu:bionic
RUN apt-get update
RUN apt-get install -qyy emacs git
RUN rm -rf $HOME/.emacs.d
COPY . /root/.emacs.d/
RUN rm -f /root/.emacs.d/packages-refreshed
RUN emacs -version
RUN cd /root/.emacs.d && emacs --batch -q -l init.el
