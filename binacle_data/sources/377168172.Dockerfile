FROM norionomura/swift@sha256:3455f611208d110f04c2420717bf2a5cf1124b23c91690fee1bdc278b8838491
ADD . TOMLDecoder
RUN cd TOMLDecoder; make test
