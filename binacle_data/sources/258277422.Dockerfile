FROM scratch

ADD ./heketi_linux_amd64 /heketi

CMD ["/heketi"]
