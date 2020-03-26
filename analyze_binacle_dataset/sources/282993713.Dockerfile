FROM base/archlinux
MAINTAINER Joe Kale

EXPOSE 8888

ADD ./connectXor /bin/connectXor
RUN pacman -Syu gnu-netcat --noconfirm
RUN echo "flag{st@t3ful_und3rfl0w}" > /flag

CMD /bin/connectXor 8888
