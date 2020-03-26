FROM ubuntu:17.04
RUN apt-get update
RUN apt-get -y install wget sudo python
COPY install_bitprim.sh /
RUN chmod 755 /install_bitprim.sh
RUN /install_bitprim.sh
RUN /bitprim/bin/bn --initchain
EXPOSE 8333
ENTRYPOINT ["/bitprim/bin/bn"]
