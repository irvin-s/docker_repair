FROM dockercask/base
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -S --noconfirm wget python2 python2-pygpgme
WORKDIR /home/docker
RUN wget -O dropbox.tar.gz https://www.dropbox.com/download?plat=lnx.x86_64
RUN wget -O /usr/bin/dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py
RUN chmod +x /usr/bin/dropbox.py
RUN ln -s /usr/bin/dropbox.py /usr/bin/dropbox
RUN ln -s /usr/bin/python2 /usr/bin/python
RUN tar xf dropbox.tar.gz
RUN rm dropbox.tar.gz
RUN chown -R docker:users /home/docker/.dropbox-dist

CMD ["script", "-a", "-f", "-c", "/home/docker/.dropbox-dist/dropboxd", "/home/docker/.dropbox/output.log"]
