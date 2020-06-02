FROM dockercask/base
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -S --noconfirm ruby
ENV PATH $PATH:/home/docker/.gem/ruby/2.4.0/bin
RUN sudo -HEu docker gem install jekyll

WORKDIR /mount

EXPOSE 4000
