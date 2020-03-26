FROM python:3

RUN apt-get update \
    && apt-get install -y \
       cmake build-essential

ENV LIBGIT2_VERSION 0.26.0

ADD https://github.com/libgit2/libgit2/archive/v${LIBGIT2_VERSION}.tar.gz .
RUN tar -xzf v${LIBGIT2_VERSION}.tar.gz && cd libgit2-${LIBGIT2_VERSION} && mkdir build && cd build && cmake .. && make && make install
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/local/lib/

RUN pip3 install pygit2

RUN echo "[user]\nemail = sample@sample.com\nname = Sample McSampleson" > /root/.gitconfig

