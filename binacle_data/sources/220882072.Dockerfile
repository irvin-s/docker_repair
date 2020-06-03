FROM gcc:latest
COPY . /usr/src/litmus
WORKDIR /usr/src/litmus
RUN ./configure
RUN make install
CMD bash
