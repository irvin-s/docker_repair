FROM nicferrier/elnode-and-nodejs
MAINTAINER nic@ferrier.me.uk
USER emacs
WORKDIR /home/emacs
RUN git clone https://github.com/nicferrier/gnudoc-js.git
WORKDIR /home/emacs/gnudoc-js
RUN npm install .
EXPOSE 8015
ENV ETAG 20140816213427254185764
CMD /usr/local/emacs/bin/emacs -daemon -l gnudoc.el ; tail -f /dev/null
