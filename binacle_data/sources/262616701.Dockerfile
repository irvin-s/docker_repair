FROM alpine:3.4

MAINTAINER Thonatos.Yang <thonatos.yang@gmail.com>
LABEL vendor=implements.io
LABEL io.implements.version=0.1.0

# update repositories
# RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories

# install package
RUN apk add --update curl gcc g++ libgcc make \
    zlib-dev openssl-dev pcre-dev ffmpeg              

RUN mkdir -p /root/build

COPY build/ /root/build

RUN cd /root/build \    
    && tar xfz s6-overlay-amd64.tar.gz -C / \    
    && tar -xvf nginx-1.8.1.tar.gz \        
    && tar -xvf nginx-rtmp-module-1.1.7.10.tar.gz \
    && cd /root/build/nginx-1.8.1 \
    && . /root/build/nginx-1.8.1/configure --add-module=/root/build/nginx-rtmp-module-1.1.7.10 \
    && make \
    && make install  
    
ADD root /

# clean cache & package
RUN apk del curl gcc g++ libgcc make \
    && rm -rf /usr/include /usr/share/man /tmp/* /var/cache/apk/* /root/build/     

# nginx
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log \ 
    && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

EXPOSE 1935 80 8080 443

ENTRYPOINT ["/init"]