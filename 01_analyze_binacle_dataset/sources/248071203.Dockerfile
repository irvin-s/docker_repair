FROM opensuse/amd64:tumbleweed
RUN zypper -n install --no-recommends ruby2.2-rubygem-ffi ruby2.2-rubygem-bundler git-core
VOLUME /src
WORKDIR /src
