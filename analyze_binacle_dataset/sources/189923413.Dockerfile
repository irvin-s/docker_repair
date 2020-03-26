FROM golang:1.5-onbuild

RUN apt-get update && apt-get install vim-nox tmux -y

WORKDIR /go/bin
RUN ssh-keygen -t rsa -b 4096 -f host_key_rsa -N ''

EXPOSE 1234

ENTRYPOINT ["./app", "-k", "host_key_rsa"]
CMD ["/bin/bash"]
