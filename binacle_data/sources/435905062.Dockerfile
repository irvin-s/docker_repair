FROM debian:stretch-slim

COPY ./libseccomp.so.2 /lib/libseccomp.so.2
COPY ./run /bin/run

RUN ln -s /proc/self/exe /bin/entry

CMD ["/bin/entry"]
