FROM ubuntu:18.04

WORKDIR /test
RUN apt update && \
    apt install -y python3 python3-pip zsh
COPY ./tests/test_shell.sh /test/
COPY ./dist /test/dist
RUN LC_ALL=C.UTF-8 LANG=C.UTF-8 pip3 install dist/$(ls dist | grep tar.gz)

CMD ["zsh", "test_shell.sh"]
