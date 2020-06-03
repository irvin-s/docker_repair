FROM ruby:2.3

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN apt-get update && apt-get install -y \
    bison \
    libunwind-dev \
    gdb \
    vim \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/longld/peda.git ~/peda \
  && echo "source ~/peda/peda.py" >> ~/.gdbinit \
  && echo "set follow-fork-mode parent" >> ~/.gdbinit \
  && echo "set disassembly-flavor intel" >> ~/.gdbinit


COPY . src
RUN cd src && git submodule update --init --recursive

RUN cd src/mruby-engine \
  && bundle install \
  && bin/rake compile

WORKDIR "/src/mruby-engine"
ENTRYPOINT ["bin/docker"]
