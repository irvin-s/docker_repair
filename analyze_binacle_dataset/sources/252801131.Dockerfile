# svendowideit/ambassador changed behaviour a couple months ago, after YEARS,  
# breaking a couple of things over here.  
#  
# So, here's a no-frills approach to rolling your own ambassadors!  
FROM alpine:3.3  
MAINTAINER Chris Weyl <chris.weyl@dreamhost.com>  
  
RUN apk update && \  
apk add socat && \  
rm -r /var/cache/  
  
# https://github.com/SvenDowideit/dockerfiles/pull/33#commitcomment-14759846  
ENTRYPOINT [ "socat", "-t", "100000000" ]  

