FROM debian:8

RUN apt-get update
RUN apt-get -y install wget

COPY tools/ /usr/local/bin

RUN mkdir /build
WORKDIR /build

# Install the big list of known prerequisites
COPY debian-8-packages.txt /build
RUN apt-get update --fix-missing
RUN apt-get -y install $(cat debian-8-packages.txt)

# Install the not-in-debian prerequisites, built with checkinstall
RUN wget https://www.quicklisp.org/quicklisp-controller/packages.tar
RUN tar xvf packages.tar
RUN dpkg -i packages/*.deb

# Other one-off requirements
RUN apt-get -y install git build-essential sudo sbcl emacs-nox apt-file
RUN apt-file update

# This gross hack makes cl-async build. Would be better to fix the
# library situation
WORKDIR /usr/lib/x86_64-linux-gnu
RUN ln -s libcrypto.so.1.0.0 libcrypto.so.1.0.2

# Create quicklisp user
RUN adduser --shell /bin/bash --uid 1000 --system quicklisp
RUN echo "quicklisp ALL = NOPASSWD: ALL" > /etc/sudoers.d/quicklisp

# Install quicklisp and quicklisp-controller prerequisites
WORKDIR /build
RUN wget https://beta.quicklisp.org/quicklisp.lisp
RUN su quicklisp -c 'sbcl --noinform --no-userinit --no-sysinit --non-interactive --load /build/quicklisp.lisp --eval "(quicklisp-quickstart:install)"'
WORKDIR /home/quicklisp/quicklisp/local-projects
RUN git clone https://github.com/quicklisp/project-info.git
RUN git clone https://github.com/xach/commando.git
RUN git clone https://github.com/xach/githappy.git

RUN git clone https://github.com/quicklisp/quicklisp-controller.git --depth 10
WORKDIR /home/quicklisp/quicklisp/local-projects/quicklisp-controller
RUN fetchcommit.sh 53ed840fa14ff546ed8615f9b8badb3be265698f

# This inhibits prompting for password on missing/private repo URLs
RUN su quicklisp -c 'git config --global core.askpass echo'

# Build SBCL
WORKDIR /build
RUN git clone https://github.com/sbcl/sbcl.git
WORKDIR /build/sbcl
RUN fetchcommit.sh sbcl-1.4.10
RUN sh make.sh --fancy
RUN sh install.sh

# Don't leave it around
RUN rm -rf /build
WORKDIR /

# Other setup
ENV LANG=C.UTF-8

COPY dot-emacs /home/quicklisp/.emacs

RUN mkdir /home/quicklisp/quicklisp-controller
RUN chown -R quicklisp /home/quicklisp/quicklisp-controller /home/quicklisp/quicklisp
RUN su quicklisp -c 'sbcl --noinform --no-userinit --no-sysinit --non-interactive --load $HOME/quicklisp/setup.lisp --eval "(ql-util:without-prompting (ql:add-to-init-file))"'
RUN su quicklisp -c 'ln -s ~/quicklisp-projects ~/quicklisp-controller/projects'
RUN su quicklisp -c 'ln -s ~/quicklisp-controller/dist/failtail-credentials.txt ~/quicklisp-controller/'

# Warm the fasl cache of quicklisp-controller
RUN su quicklisp -c 'sbcl --no-userinit --no-sysinit --non-interactive --load $HOME/quicklisp/setup.lisp --eval "(ql:quickload :quicklisp-controller)"'

# SLIME
RUN su quicklisp -c 'sbcl --no-userinit --no-sysinit --non-interactive --load $HOME/quicklisp/setup.lisp --eval "(ql:quickload :quicklisp-slime-helper)"'

# Required binaries
WORKDIR /home/quicklisp
RUN su quicklisp -c 'mkdir /home/quicklisp/bin'
RUN su quicklisp -c 'sbcl --non-interactive --eval "(ql:quickload :buildapp)" --eval "(buildapp:build-buildapp \"~/bin/buildapp\")"'
RUN su quicklisp -c 'sbcl --non-interactive --eval "(ql:quickload :quicklisp-controller)" --eval "(quicklisp-controller::rebuild-tools)"'

# Make buildapp &c visible in ~/bin
RUN su quicklisp -c 'echo export PATH=$PATH:$HOME/bin >> ~/.profile'
RUN su quicklisp -c 'echo export PATH=$PATH:$HOME/bin >> ~/.bashrc'
RUN su quicklisp -c 'echo export LANG=C.UTF-8 >> ~/.profile'

# Start as quicklisp, not root
USER quicklisp

