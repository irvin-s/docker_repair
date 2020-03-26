FROM scratch

# Allow `linker64` to load stubbed binaries
ENV LD_LIBRARY_PATH /root
# ENV LD_DEBUG 1

# Copy `bionic`, built libraries and `libocr.so`
COPY bin/system/ /system/
COPY build/libs/x86_64/ /root/
COPY build/ocr_x86_64/ /root/

# Run contents in the `/root`
WORKDIR /root

ENTRYPOINT ["/root/mognet"]
