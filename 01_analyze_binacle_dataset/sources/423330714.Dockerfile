FROM ubuntu:14.04
MAINTAINER James C. Scott III <jcscott.iii@gmail.com>

# Create non-root user
ENV USERNAME gopher
ENV HOME /home/$USERNAME
RUN groupadd -r $USERNAME -g 757 && \
     useradd -u 757 --create-home --home-dir $HOME $USERNAME -g $USERNAME && \
     chown -R $USERNAME:$USERNAME $HOME && \
     echo "$USERNAME:$USERNAME" | chpasswd && adduser $USERNAME sudo # Give user ability to use sudo

# Update all the package references available for download
RUN apt-get update

# Setup for non-interactive install
ENV DEBIAN_FRONTEND noninteractive

# Install tools
RUN apt-get install -y \
    python-software-properties=0.92.37.6 \
    software-properties-common=0.92.37.6
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update
RUN apt-get install -y \
    gcc-4.9=4.9.3-8ubuntu2~14.04 \
    git=1:1.9.1-1ubuntu0.1 \
    make=3.81-8.2ubuntu3 \
    wget=1.15-1ubuntu1.14.04.1

RUN ln -s /usr/bin/gcc-4.9 /usr/bin/gcc

RUN apt-get clean

# Switch to non-root user
USER $USERNAME
RUN mkdir $HOME/bin
ENV PATH $HOME/bin:$PATH

# Go-specific instructions.
# Install Go 1.5.2
# Reference link: https://golang.org/dl/
RUN wget https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz -O $HOME/go.tar.gz
RUN mkdir $HOME/go && tar -C $HOME -xzf $HOME/go.tar.gz && rm $HOME/go.tar.gz
RUN ln -s $HOME/go/bin/go $HOME/bin/go

# Set the gopath
RUN mkdir -p $HOME/project/src
ENV GOPATH $HOME/project
ENV GOROOT $HOME/go

# Install tools
RUN go get -u -v github.com/nsf/gocode github.com/rogpeppe/godef github.com/golang/lint/golint github.com/lukehoban/go-find-references sourcegraph.com/sqs/goreturns golang.org/x/tools/cmd/gorename

# Install the debugger
ENV GO15VENDOREXPERIMENT 1
RUN git clone https://github.com/derekparker/delve.git $GOPATH/src/github.com/derekparker/delve
RUN cd $GOPATH/src/github.com/derekparker/delve && git checkout v0.9.0-alpha && make install

# Preserve the PATH because when we run `su $USERNAME`, PATH would have been reset.
# Part of workaround discussed in entry.sh
RUN echo "export PATH=$PATH:$GOPATH/bin" >> $HOME/.bashrc

# Remove all files in the src folder to clean up
RUN rm -rf $GOPATH/src/*

# Set the workspace
WORKDIR $GOPATH
USER root
# Add the entrypoint script
ADD entry.sh $HOME/bin/entry.sh
RUN chmod +x $HOME/bin/entry.sh
USER $USERNAME

ENTRYPOINT "$HOME/bin/entry.sh"
