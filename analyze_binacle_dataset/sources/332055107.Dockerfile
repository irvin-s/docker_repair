FROM tuddman/graalvm:latest AS BASE
MAINTAINER tuddman

COPY target/classes/ /target
WORKDIR /target

ENV GRAAL_VERSION=1.0.0-rc3
ENV MAIN_CLASS=com.example.hello
RUN /usr/graalvm-ce-${GRAAL_VERSION}/bin/native-image ${MAIN_CLASS} 

FROM scratch

COPY --from=BASE /lib64/libc.so.6 /lib64/libc.so.6
COPY --from=BASE /lib64/libdl.so.2 /lib64/libdl.so.2
COPY --from=BASE /lib64/libpthread.so.0 /lib64/libpthread.so.0
COPY --from=BASE /lib64/libz.so.1 /lib64/libz.so.1
COPY --from=BASE /lib64/librt.so.1 /lib64/librt.so.1
COPY --from=BASE /lib64/libcrypt.so.1 /lib64/libcrypt.so.1
COPY --from=BASE /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY --from=BASE /lib64/libfreebl3.so /lib64/libfreebl3.so

COPY --from=BASE /target/${MAIN_CLASS} /

CMD ["/${MAIN_CLASS}"]
