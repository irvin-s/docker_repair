FROM ubuntu:18.04

WORKDIR /test
RUN apt update && \
    apt install -y python python-pip zsh
COPY ./tests/test_shell.sh /test/
RUN LC_ALL=C.UTF-8 LANG=C.UTF-8 pip install goto-cd

CMD ["zsh", "test_shell.sh"]
