FROM alpine:3.6 AS builder  
  
RUN set -ex; \  
\  
apk add --no-cache --virtual .build-deps \  
coreutils \  
gcc \  
linux-headers \  
make \  
musl-dev \  
;  
  
RUN mkdir -p /usr/src/peps  
COPY . /usr/src/peps  
RUN make -C /usr/src/peps/  
  
FROM redis:4.0.8-alpine  
  
COPY \--from=builder /usr/src/peps/peps.so /usr/local/bin/  
CMD ["redis-server", "--loadmodule", "/usr/local/bin/peps.so"]  

