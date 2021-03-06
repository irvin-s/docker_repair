FROM ubuntu
RUN apt-get update --fix-missing
RUN apt-get install -y \
    libcap2 libcap-dev \
    libclang1-6.0 libclang-6.0-dev clang \
    libllvm6.0 llvm llvm-dev \
    gcc \
    make xxd
COPY . /usr/src/penguintrace
RUN cd /usr/src/penguintrace && \
    make -j8 && \
    cp build/bin/penguintrace /bin/ && \
    rm -rf /usr/src/penguintrace && \
    echo "SERVER_GLOBAL=true\nSERVER_IPV6=true" > /penguintrace.cfg
CMD ["penguintrace"]
