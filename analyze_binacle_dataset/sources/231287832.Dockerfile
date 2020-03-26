FROM strato-build

RUN install-deb http://mirrors.kernel.org/ubuntu/pool/main/g/gccgo-6/libgcc1_6.0.1-0ubuntu1_amd64.deb \
    && install-deb http://mirrors.kernel.org/ubuntu/pool/main/g/gccgo-6/gcc-6-base_6.0.1-0ubuntu1_amd64.deb \
    && install-deb http://mirrors.kernel.org/ubuntu/pool/main/g/glibc/libc6_2.23-0ubuntu3_amd64.deb
