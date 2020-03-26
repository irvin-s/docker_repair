FROM alpine:latest

ENV HOME /home/user
WORKDIR /tmp
ADD ./znc.conf $HOME/.znc/configs/znc.conf
RUN apk add --update g++ make git automake m4 cmake \
    && rm -rf /var/cache/apk/* \
    && git clone https://github.com/znc/znc.git \
    && cd znc \
    && git submodule update --init --recursive \
    && cmake . \
    && make \
    && make install \
    && rm -rf /tmp/* \
    && adduser -D -h $HOME user user \
    && chown -R user:user $HOME
USER user
EXPOSE 6060
CMD ["znc", "--foreground"]
