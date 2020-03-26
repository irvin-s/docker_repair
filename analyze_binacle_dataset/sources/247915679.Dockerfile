FROM ubuntu

RUN apt-get update && apt-get install -y curl xz-utils g++ git
RUN curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y
ENV PATH=/root/.nimble/bin:$PATH