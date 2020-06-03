FROM alpine:latest

ENV LLVM=/emscripten-fastcomp/build/bin \
    EMSCRIPTEN=/emscripten \
    BINARYEN=/binaryen \
    PATH=/emscripten:$PATH

RUN apk --no-cache --update --virtual build-dependencies add git build-base g++ nasm libc-dev cmake \
    && apk add bash python nodejs \
    && git clone --single-branch --branch alpine-linux-support --depth 1 https://github.com/inikolaev/emscripten-fastcomp.git \
    && cd emscripten-fastcomp \
    && git clone --single-branch --branch incoming --depth 1 https://github.com/kripken/emscripten-fastcomp-clang tools/clang \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=MinSizeRel \
                -DLLVM_TARGETS_TO_BUILD="X86;JSBackend" \
                -DLLVM_INCLUDE_EXAMPLES=OFF \
                -DLLVM_INCLUDE_TESTS=OFF \
                -DCLANG_INCLUDE_EXAMPLES=OFF \
                -DCLANG_INCLUDE_TESTS=OFF \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && cd / \
    && git clone --single-branch --branch incoming --depth 1 https://github.com/kripken/emscripten.git \
    && git clone --single-branch --depth 1 https://github.com/WebAssembly/binaryen \
    && cd binaryen \
    && cmake . \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && rm -f /var/cache/apk/* \
    && apk del build-dependencies \
    && emcc

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["emcc"]
