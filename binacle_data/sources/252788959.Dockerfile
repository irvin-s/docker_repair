# lwp-request in a container  
#  
# docker run --rm -it \  
# \--net host \  
# \--log-driver none \  
# drphlux/lwp-request "$@"  
#  
FROM alpine:latest  
MAINTAINER DrPhlux  
RUN apk update && apk add \  
perl-libwww perl-lwp-protocol-https \  
&& rm -rf /var/cache/apk/*  
  
ENTRYPOINT [ "lwp-request" ]  

