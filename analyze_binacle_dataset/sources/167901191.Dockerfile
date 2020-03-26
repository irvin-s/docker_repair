FROM docker.km3net.de/base/python:3
 MAINTAINER Tamas Gal <tgal@km3net.de>

 ENV INSTALL_DIR /km3pipe
 ADD . $INSTALL_DIR
 RUN cd $INSTALL_DIR && make install
 RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
    >> /etc/bash.bashrc \
    ; echo "\\n\
    _/                        _/_/_/              _/                  \n\
   _/  _/    _/_/_/  _/_/          _/  _/_/_/        _/_/_/      _/_/ \n\
  _/_/      _/    _/    _/    _/_/    _/    _/  _/  _/    _/  _/_/_/_/\n\
 _/  _/    _/    _/    _/        _/  _/    _/  _/  _/    _/  _/      \n\ 
_/    _/  _/    _/    _/  _/_/_/    _/_/_/    _/  _/_/_/      _/_/_/ \n\ 
                                   _/            _/                  \n\ 
                                  _/            _/                   \n\ 
\n$(km3pipe --version)\n\
(c) Tamas Gal, Moritz Lotze and the KM3NeT Collaboration 2018\n\
\n\
Source directory is $INSTALL_DIR\n"\
    > /etc/motd
 WORKDIR /km3pipe/examples
 ENTRYPOINT /bin/bash
