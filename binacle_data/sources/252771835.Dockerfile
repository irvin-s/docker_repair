FROM alpine:3.7  
MAINTAINER Guillaume Poittevin <gpo@atolcd.com>  
  
RUN apk add --update git squashfs-tools && rm -rf /var/cache/apk/*  
  
ENTRYPOINT [ "mksquashfs" ]

