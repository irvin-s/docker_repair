FROM swift

ADD ./install-nanomsg.sh /tmp/install-nanomsg.sh
RUN /tmp/install-nanomsg.sh
RUN rm -rf /tmp/*
