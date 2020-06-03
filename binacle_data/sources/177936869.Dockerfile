FROM ubuntu:14.04

ADD https://github.com/nickschuch/marco/releases/download/2.0.0/marco-Linux-x86_64 /marco
RUN chmod a+x /marco

CMD ["/marco"]
