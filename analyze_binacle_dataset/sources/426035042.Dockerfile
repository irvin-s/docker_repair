FROM ubuntu:saucy
MAINTAINER lucas@rufy.com

ADD https://www.dropbox.com/download?plat=lnx.x86_64 /dropbox.tgz
RUN tar xfvz /dropbox.tgz && rm /dropbox.tgz

CMD /.dropbox-dist/dropboxd
