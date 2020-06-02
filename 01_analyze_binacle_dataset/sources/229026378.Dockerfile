# Run an Apple Swift build on Fedora 23 with the linux_buildbot preset
# using a codebase provided in a Volume.

FROM fedora:23

MAINTAINER https://github.com/eosrei/docker-swift-dev-buildbot

# Volume mounted from host to access source code. [Required]
VOLUME ["/src"]
# Volume to store compiled package and build log. [Optional]
VOLUME ["/output"]

# Where build-script will store the build files
ENV SWIFT_BUILD_ROOT /build

COPY build.sh /root/build.sh

# Note: git config required for swiftpm/Tests/dep/FunctionalBuildTests.swift
RUN deps='git cmake ninja-build libuuid-devel icu libbsd-devel \
      libedit-devel libxml2-devel libsq3-devel swig python-devel \
      ncurses-devel pkgconfig ca-certificates python rsync file python3 \
      libicu-devel clang which tar autoconf automake libcurl-devel'; \
    dnf -y update \
    && dnf -y install $deps \
    && dnf clean all \
    && rm -rf /usr/share/doc /usr/share/man \
    && git config --global user.email "root@example.com" \
    && git config --global user.name "Root" \
    && chmod +x /root/build.sh

# Workarounds for Fedora/Redhat/CentOS
# Symlinks ninja -> ninja-build for:
# * https://bugzilla.redhat.com/show_bug.cgi?id=1166135
#
# Symlinks lib64/python2.7 -> lib/python for:
# * https://bugs.swift.org/browse/SR-100
# * https://llvm.org/bugs/show_bug.cgi?id=18957
# * https://llvm.org/bugs/show_bug.cgi?id=23785
RUN ln -s /usr/bin/ninja-build /usr/bin/ninja \
    && mkdir -p /build/buildbot_linux/lldb-linux-x86_64/lib \
    && mkdir -p /build/buildbot_linux/lldb-linux-x86_64/lib64/python2.7 \
    && ln -s /build/buildbot_linux/lldb-linux-x86_64/lib64/python2.7 /build/buildbot_linux/lldb-linux-x86_64/lib/python2.7

CMD ["/root/build.sh"]
