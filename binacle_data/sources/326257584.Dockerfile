FROM alpine:3.9
RUN apk add libgcc
COPY bin/aergosvr /usr/local/bin/
COPY lib/* /usr/local/lib/
COPY conf/* /aergo/
ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
CMD ["aergosvr", "--home", "/aergo"]
EXPOSE 7845 7846 6060
