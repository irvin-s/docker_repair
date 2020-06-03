FROM pygatb/alpine_runtime_base

RUN apk --no-cache add cmake make g++ zlib-dev python3-dev \
 && pip3 install --no-cache-dir Cython --install-option="--no-cython-compile"
CMD ash /usr/local/bin/build -DENABLE_LTO=ON
COPY build.sh /usr/local/bin/build
