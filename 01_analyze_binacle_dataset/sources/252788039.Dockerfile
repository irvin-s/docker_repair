FROM alpine:3.6  
LABEL maintainer "i@giuem.com"  
  
WORKDIR /app/build  
  
COPY . /app  
  
RUN apk add --no-cache \  
g++ cmake make libstdc++ libgcc util-linux-dev openssl-dev zlib-dev && \  
cd /app/include/uWebSockets && make && make install && cd /app/build && \  
cmake -DCMAKE_BUILD_TYPE=Release .. && make && \  
apk del g++ cmake make  
  
ENV PORT 4000  
EXPOSE $PORT/tcp  
  
CMD ["./server"]

