# Run a basic Apple Swift build to generate a ${BUILD} directory for use with
# buildbot_linux presets. Saves time on one-off builds, but shouldn't be used
# for regular development since the layered file system will keep old files.

FROM eosrei/swift-dev-buildbot:14.04

# Store the source in the temporary volume
WORKDIR /src

# Run build-script with settings similar to the buildbot_linux preset, but without
# any of the tests.
# TODO: Make a custom preset?
RUN git clone --depth 1 https://github.com/apple/swift.git swift \
    && git clone --depth 1 https://github.com/apple/swift-llvm.git llvm \
    && git clone --depth 1 https://github.com/apple/swift-clang.git clang \
    && git clone --depth 1 https://github.com/apple/swift-lldb.git lldb \
    && git clone --depth 1 https://github.com/apple/swift-cmark.git cmark \
    && git clone --depth 1 https://github.com/apple/swift-llbuild.git llbuild \
    && git clone --depth 1 https://github.com/apple/swift-package-manager.git swiftpm \
    && git clone --depth 1 https://github.com/apple/swift-corelibs-xctest.git \
    && git clone --depth 1 https://github.com/apple/swift-corelibs-foundation.git \
    && /src/swift/utils/build-script --assertions --llbuild --swiftpm --xctest \
      --build-subdir=buildbot_linux --lldb --release --foundation -- \
      --swift-enable-ast-verifier=0 --build-swift-static-stdlib=1 --reconfigure \
    && rm -rf /src/*

CMD ["/root/build.sh"]
