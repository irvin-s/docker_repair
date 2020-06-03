FROM algorithmia/langpack-single-base

# For each lang, run `setup`
RUN ( for lang in /tmp/*; do \
        echo "Running $lang setup"; \
        $lang/setup || exit; \
    done ) && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
        gcc-4.6 g++-4.6 gcc-4.6-multilib g++-4.6-multilib gfortran \
        linux-headers-generic \
        linux-image-generic


RUN curl -LO https://s3.amazonaws.com/algorithmia-docker/docker-deps/cuda_8.0.44_linux.run && \
    chmod +x cuda_8.0.44_linux.run && \
    sh ./cuda_8.0.44_linux.run --toolkit --silent && \
    rm cuda_8.0.44_linux.run

RUN curl -LO https://s3.amazonaws.com/algorithmia-docker/docker-deps/cudnn-8.0-linux-x64-v5.1.tgz && \
    tar -xf cudnn-8.0-linux-x64-v5.1.tgz && \
    mv cuda/include/* /usr/local/cuda/include && \
    mv cuda/lib64/* /usr/local/cuda/lib64 && \
    rm cudnn-8.0-linux-x64-v5.1.tgz

RUN ldconfig /usr/local/cuda/lib64
ENV PATH=/usr/local/cuda/bin:$PATH \
	LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

WORKDIR /tmp/build
CMD ["bin/build"]

USER algo
