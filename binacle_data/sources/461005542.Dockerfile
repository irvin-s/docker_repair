FROM multiarch/crossbuild

# reinstall osx cross compiler to link with SDK 10.7

ENV DARWIN_OSX_VERSION_MIN="10.7"
RUN rm -rf /usr/osxcross \
 && mkdir -p "/tmp/osxcross"                                                                                   \
 && cd "/tmp/osxcross"                                                                                         \
 && curl -sLo osxcross.tar.gz "https://codeload.github.com/${OSXCROSS_REPO}/tar.gz/${OSXCROSS_REVISION}"  \
 && tar --strip=1 -xzf osxcross.tar.gz                                                                         \
 && rm -f osxcross.tar.gz                                                                                      \
 && curl -sLo tarballs/MacOSX${DARWIN_SDK_VERSION}.sdk.tar.xz                                                  \
             "${DARWIN_SDK_URL}"                \
 && yes "" | SDK_VERSION="${DARWIN_SDK_VERSION}" OSX_VERSION_MIN="${DARWIN_OSX_VERSION_MIN}" ./build.sh                               \
 && mv target /usr/osxcross                                                                                    \
 && mv tools /usr/osxcross/                                                                                    \
 && ln -sf ../tools/osxcross-macports /usr/osxcross/bin/omp                                                    \
 && ln -sf ../tools/osxcross-macports /usr/osxcross/bin/osxcross-macports                                      \
 && ln -sf ../tools/osxcross-macports /usr/osxcross/bin/osxcross-mp                                            \
 && rm -rf /tmp/osxcross                                                                                       \
 && rm -rf "/usr/osxcross/SDK/MacOSX${DARWIN_SDK_VERSION}.sdk/usr/share/man"

# install toolchain
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

# install target
RUN rustup target add x86_64-apple-darwin

WORKDIR /work
