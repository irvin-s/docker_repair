# sysstat
# docker run --rm -it -v $(pwd):/work supinf/sysstat:11.5 sar -f sar.data -n ALL

FROM alpine:3.6

RUN apk --no-cache add sysstat==11.5.4-r0

WORKDIR /work
