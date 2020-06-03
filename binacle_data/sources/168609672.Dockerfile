FROM sjackman/linuxbrew-gcc
MAINTAINER Shaun Jackman <sjackman@gmail.com>

RUN brew install git
RUN brew tap homebrew/dupes
RUN brew install coreutils findutils gawk gnu-sed gnu-which grep make
RUN brew install ruby

RUN brew doctor
