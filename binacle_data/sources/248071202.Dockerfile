FROM opensuse/amd64:leap
RUN zypper -n install --no-recommends ruby2.1-rubygem-ffi ruby2.1-rubygem-rake ruby2.1-rubygem-bundler git-core
VOLUME /src
WORKDIR /src
